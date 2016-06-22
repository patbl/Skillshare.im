OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  options = {
    scope: 'email,user_location',
    image_size: :normal,
    client_options: {
      site: 'https://graph.facebook.com/v2.6',
      authorize_url: "https://www.facebook.com/v2.6/dialog/oauth",
    },
    token_params: { parse: :json },
  }
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], options
  provider :browser_id
  provider :developer, fields: %i[name], uid_field: :name if Rails.env.development?
end

# in the development environment, redirect instead of raising an
# exception when the user cancels third-party authentication
# http://stackoverflow.com/questions/10963286/callback-denied-with-omniauth
OmniAuth.config.on_failure = proc { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
