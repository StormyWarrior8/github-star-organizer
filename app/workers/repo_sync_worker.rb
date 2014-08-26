class RepoSyncWorker
  include Sidekiq::Worker

  sidekiq_options queue: :repo_sync, retry: false

  def perform user_id
    User.find(user_id).sync_stared_repos
  end
end
