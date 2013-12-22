class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  helper_method :current_user, :signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end

  def ensure_signed_in
    unless current_user
      store_url request.fullpath
      redirect_to signin_path
    end
  end

  def store_url(url, **options)
    session[:return_to] ||= []
    session[:return_to].push [url, options] if url
  end

  def redirect_back_or(path, options = {})
    if session[:return_to].present?
      path, saved_options = session[:return_to].shift
      options.update(saved_options)
    end
    redirect_to path, options
  end
end
