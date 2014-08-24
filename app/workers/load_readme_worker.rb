class LoadReadmeWorker
  include Sidekiq::Worker

  sidekiq_options queue: :repo_sync, retry: false

  def perform repo_id
    stared_repo = StaredRepo.find(repo_id)
    stared_repo.update_column :readme_html, Octokit::Client.new.readme(stared_repo.full_name, accept: 'application/vnd.github.v3.html')
  end
end