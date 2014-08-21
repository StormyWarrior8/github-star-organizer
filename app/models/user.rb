class User < ActiveRecord::Base
  ## Third-party extension
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
    :validatable, :omniauthable, omniauth_providers: %i(github)

  ## Associations
  has_many :stared_repos

  ## Validations
  with_options presence: true do |pt|
    pt.validates :name
    pt.with_options uniqueness: true do |ut|
      ut.validates :github_username
      ut.validates :github_uid
    end
  end


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
  def github_api
    @github_api ||= Github::UserApiClient.new self.github_username
  end
end
