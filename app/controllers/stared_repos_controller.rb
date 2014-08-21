class StaredReposController < ApplicationController
  def index
    @stared_repos = current_user.stared_repos
  end
end
