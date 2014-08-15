APP_CONFIG = HashWithIndifferentAccess.new(YAML.load_file('config/application.yml')[Rails.env]) rescue {}
