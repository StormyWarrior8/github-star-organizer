module Github
  class UserApiClient < ApiClient
    def initialize username
      super()
      @username = username
      @user_client = @client.user(username)
    end

    attr_reader :username, :user_client
  end
end
