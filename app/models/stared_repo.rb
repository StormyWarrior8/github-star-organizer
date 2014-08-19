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

  private
    def parse_readme_html
      self.readme_html = Octokit.readme(self.full_name, accept: 'application/vnd.github.html') rescue ''
    end
end
