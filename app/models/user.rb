class User < ActiveRecord::Base
  ## Third-party extension
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
    :validatable, :omniauthable, omniauth_providers: %i(github)

  ## Associations
  has_many :stared_repos

  ## Validations
  validates :name, presence: true

  ## Class methods
  def self.from_omniauth auth
    self.find_or_create_by("#{auth[:provider]}_uid" => auth[:uid]) do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
    end
  end
end
