class RepoSyncWorker

  include Sidekiq::Worker

  def perform user_name
    uri = URI.parse("https://api.github.com/users/" + user_name +"/starred")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    logger.info 'response is ' + response.body
  end
end