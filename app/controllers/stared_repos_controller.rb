class StaredReposController < ApplicationController

  respond_to :json

  def index
    @stared_repos = current_user.stared_repos.includes(:tags)
  end

  def update
    @stared_repo = current_user.stared_repos.find(params[:id])
    @stared_repo.update(params.require(:stared_repo).permit(:user_tag_list))
    render nothing: true
  end

  def sync
    current_user.start_sync_job
    render nothing: true
  end

  def tag_list
    render json: current_user.owned_tags.where("name LIKE '%#{params[:term]}%'").map(&:name)
  end
end
