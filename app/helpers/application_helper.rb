module ApplicationHelper
  def js_routes
    {
      tags_autocomplete_path: tag_list_stared_repos_path,
      stared_repos_path: stared_repos_path
    }
  end
end
