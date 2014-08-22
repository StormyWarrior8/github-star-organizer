class StaredReposController < ApplicationController
  def index
    @stared_repos = current_user.stared_repos
  end

  def sync
    current_user.start_sync_job
    render nothing: true
  end
end
