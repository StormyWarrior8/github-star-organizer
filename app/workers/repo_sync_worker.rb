class RepoSyncWorker

  include Sidekiq::Worker

  def perform user_id, access_token
    uri = URI.parse("https://api.github.com/user/starred")
    uri.query = URI.encode_www_form(:access_token => access_token)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    logger.info 'response is ' + response.body
    stared_repos = JSON.parse(response.body)
    stared_repos.each do |repo|
      StaredRepo.find_or_create_by(:remote_id => repo[:id]) do |rec|
        rec.user_id = user_id
        rec.name = repo[:name]
        rec.full_name = repo[:full_name]
        rec.description = repo[:description]
        rec.homepage = repo[:homepage]
        rec.ssh_url = repo[:url]
        rec.html_url = repo[:html_url]
        rec.stargazers_count = repo[:stargazers_count]
        rec.pushed_at = repo[:pushed_at]
      end
    end
  end
end

