class RepoSyncWorker
  include Sidekiq::Worker

  sidekiq_options queue: :repo_sync, retry: false

  def perform user_id
    user = User.find(user_id)
    repo_attrs_for_save = %i(name full_name description homepage ssh_url html_url stargazers_count pushed_at)

    Octokit::Client.new.starred(user.github_username).each do |repo_attrs|
      stared_repo = user.stared_repos.where(remote_id: repo_attrs[:id]).first_or_initialize
      stared_repo.assign_attributes repo_attrs.to_h.slice(*repo_attrs_for_save)
      stared_repo.save
    end
  end
end
