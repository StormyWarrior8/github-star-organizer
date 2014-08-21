class StaredRepo < ActiveRecord::Base
  ## Associations
  belongs_to :user

  ## Validations
  with_options presence: true do |pt|
    pt.validates :user_id
    pt.validates :name
    pt.validates :full_name, format: { with: /.*\/.*/ }, uniqueness: { scope: :user_id }
  end

  ## Callbacks
  before_save :parse_readme_html

  ##taggable
  acts_as_taggable_on :tags

  private
    def parse_readme_html
      self.readme_html = Github::ApiClient.new.readme_html(self.full_name)
    end
end
