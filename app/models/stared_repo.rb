class StaredRepo < ActiveRecord::Base
  ## Constants
  REMOTE_ATTRS = %i(name full_name description homepage ssh_url html_url stargazers_count pushed_at)

  ## Third-party extension
  acts_as_taggable_on :tags

  ## Associations
  belongs_to :user

  ## Validations
  with_options presence: true do |pt|
    pt.validates :user_id
    pt.validates :name
    pt.validates :full_name, format: { with: /.*\/.*/ }, uniqueness: { scope: :user_id }
  end

  ## Callbacks
  before_create :parse_readme_html

  ## Attributes
  attr_accessor :user_tag_list

  ## Class methods
  class << self
    def create_from_remote data
      self.where(remote_id: data[:id]).first_or_initialize.tap do |repo|
        repo.assign_attributes data.to_h.slice(*REMOTE_ATTRS)
        repo.first_commit_at = data[:created_at]
        repo.starred_at = data[:updated_at]
        repo.save
      end
    end
  end


  ## Instance methods
  def user_tag_list
    self.tags.map(&:name).join(', ')
  end

  def user_tag_list= value
    self.user.tag(self, with: value, on: :tags)
  end

  private
    def parse_readme_html
      self.readme_html = Octokit::Client.new.readme(self.full_name, accept: 'application/vnd.github.v3.html')
    end
end
