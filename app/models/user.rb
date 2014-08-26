class User < ActiveRecord::Base
  ## Third-party extension
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
    :validatable, :omniauthable, omniauth_providers: %i(github)
  acts_as_tagger

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
  class << self
    def from_omniauth auth
      provider = auth[:provider]

      self.find_or_create_by("#{provider}_uid" => auth[:uid]) do |user|
        user["#{provider}_username"] = auth.info.nickname
        user.email = auth.info.email
        user.name = auth.info.name
        user.password = Devise.friendly_token[0,20]
      end
    end
  end


  ## Instance methods
  def current_sync_job?
    Sidekiq::Status::status(self.sync_job_id).in?(%i[queued working])
  end

  def start_sync_job
    self.update_column :sync_job_id, RepoSyncWorker.perform_async(self.id) unless current_sync_job?
  end

  def sync_stared_repos
    remote_repos = Octokit::Client.new.starred(self.github_username)
    remote_repos.each{ |data| self.stared_repos.create_from_remote(data) }
    self.stared_repos.where.not(remote_id: remote_repos.map{ |attrs| attrs[:id] }).destroy_all
  end
end
