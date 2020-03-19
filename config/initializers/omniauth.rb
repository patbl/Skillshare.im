OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :facebook,
    Rails.application.credentials.fetch(Rails.env.to_sym).fetch(:facebook_app_id),
    Rails.application.credentials.fetch(Rails.env.to_sym).fetch(:facebook_app_secret),
    scope: "email,public_profile",
    image_size: :normal,
    info_fields: "first_name,last_name,location,link,email",
    # token_params: { parse: :json },
  )
end

# in the development environment, redirect instead of raising an
# exception when the user cancels third-party authentication
# http://stackoverflow.com/questions/10963286/callback-denied-with-omniauth
OmniAuth.config.on_failure = proc { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}
