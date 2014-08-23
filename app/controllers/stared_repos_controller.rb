class StaredReposController < ApplicationController
  def index
    @stared_repos = current_user.stared_repos
  end

  def sync
    current_user.start_sync_job
    render nothing: true
  end

  def auto_complete_tags
    term = params[:term]
    searched_tags = current_user.search_for_tags term
    render json: searched_tags
  end
end
