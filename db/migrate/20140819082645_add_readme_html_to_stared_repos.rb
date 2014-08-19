class AddReadmeHtmlToStaredRepos < ActiveRecord::Migration
  def change
    add_column :stared_repos, :readme_html, :text
  end
end
