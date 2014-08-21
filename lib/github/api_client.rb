module Github
  class ApiClient
    def initialize
      @client = Octokit::Client.new APP_CONFIG[:api_app][:github]
    end

    attr_reader :client

    def readme_html repo_name
      self.client.readme(repo_name, accept: 'application/vnd.github.html') rescue ''
    end
  end
end
