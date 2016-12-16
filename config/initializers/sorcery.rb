Rails.application.config.sorcery.submodules = [:external]
Rails.application.config.sorcery.configure do |config|
  config.external_providers = [:facebook, :twitter]
  config.facebook.key = Rails.application.secrets.sorcery_facebook_key
  config.facebook.secret = Rails.application.secrets.sorcery_facebook_secret
  config.facebook.callback_url = "http://flashcardsapa092.herokuapp.com/oauth/callback?provider=facebook"
  config.facebook.user_info_mapping = { email: "name" }
  config.facebook.access_permissions = %w(email publish_actions)
  config.facebook.display = "page"
  config.facebook.api_version = "v2.2"
  config.user_config do |user|
    user.authentications_class = Authentication
  end
  config.user_class = 'User'
end
