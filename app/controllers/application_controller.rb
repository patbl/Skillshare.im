class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def ensure_signed_in
    unless current_user
      store_requested_url
      redirect_to signin_path
    end
  end

  def store_requested_url(**options)
    store_url request.fullpath, options
  end

  def store_previous_url(**options)
    store_url request.referer, options
  end

  def store_url(url, options)
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
