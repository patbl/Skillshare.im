OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  options = {
    scope: "email,public_profile",
    image_size: :normal,
    info_fields: "first_name,last_name,location,link,email",
    client_options: {
      site: "https://graph.facebook.com/v2.10",
      authorize_url: "https://www.facebook.com/v2.10/dialog/oauth",
    },
    token_params: { parse: :json },
  }
  provider :facebook,
    Rails.application.credentials.fetch(Rails.env.to_sym).fetch(:facebook_app_id),
    Rails.application.credentials.fetch(Rails.env.to_sym).fetch(:facebook_app_secret),
    options
  provider :developer, fields: %i[name], uid_field: :name if Rails.env.development?
end

# in the development environment, redirect instead of raising an
# exception when the user cancels third-party authentication
# http://stackoverflow.com/questions/10963286/callback-denied-with-omniauth
OmniAuth.config.on_failure = proc { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
