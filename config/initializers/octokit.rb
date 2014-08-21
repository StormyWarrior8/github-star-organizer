Octokit.configure do |c|
  c.auto_paginate = true
  c.client_id = APP_CONFIG[:api_app][:github][:client_id]
  c.client_secret = APP_CONFIG[:api_app][:github][:client_secret]
end
