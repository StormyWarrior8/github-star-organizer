class User < ActiveRecord::Base
  ## Third-party extension
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
    :validatable, :omniauthable, omniauth_providers: %i(github)

  ## Associations
  has_many :stared_repos, dependent: :destroy

  ## Validations
  with_options presence: true do |pt|
    pt.validates :name
    pt.with_options uniqueness: true do |ut|
      ut.validates :github_username
      ut.validates :github_uid
    end
  end

  ## Callbacks
  after_create :start_sync_job


  ## Class methods
  def self.from_omniauth auth
    provider = auth[:provider]

    self.find_or_create_by("#{provider}_uid" => auth[:uid]) do |user|
      user["#{provider}_username"] = auth.info.nickname
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end


  ## Instance methods
  def start_sync_job
    unless Sidekiq::Status::status(self.sync_job_id).in?(%i[queued working])
      self.update_column :sync_job_id, RepoSyncWorker.perform_async(self.id)
    end
  end

  def search_for_tags term
    arr = []
    arr << stared_repos.map{ |rep| rep.get_searched_tags(term)}
    hash = Hash[arr.flatten.uniq.each_with_index.map { |v,i| [i,v] }]
    hash.to_json
  end
end
