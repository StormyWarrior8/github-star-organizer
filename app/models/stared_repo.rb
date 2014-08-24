class StaredRepo < ActiveRecord::Base
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
