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
  after_save :parse_readme_html

  ##taggable
  acts_as_taggable_on :tags

  def get_searched_tags term
    tag_list.select{ |tag| tag.match(/^#{term}/) }
  end

  private
    def parse_readme_html
      LoadReadmeWorker.perform_async(self.id)
    end
end
