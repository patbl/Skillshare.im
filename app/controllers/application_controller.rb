class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :error
  before_action :authorize

  protected

  helper_method :current_user, :signed_in?, :guest?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session.delete(:user_id)
    nil
  end

  def guest?
    !current_user
  end

  def signed_in?
    !guest?
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end

  def authorize
    return unless guest?

    store_url(request.fullpath)
    redirect_to(sign_in_path)
  end

  def store_url(url, **options)
    session[:return_to] ||= []
    session[:return_to] << [url, options]
  end

  def get_url
    (session[:return_to] ||= []).shift
  end

  def redirect_back_or(default_path, default_options = {})
    path, options = get_url
    path ||= default_path
    options = default_options.merge(options || {})
    redirect_to(path, options)
  end
end
