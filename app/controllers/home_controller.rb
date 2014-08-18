class HomeController < ApplicationController

  def index
    if current_user
      RepoSyncWorker.perform_async(current_user.name)
    end
  end
end
