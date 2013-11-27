class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  helper_method :current_user, :redirect_to_previous_or_default, :ensure_signed_in

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def ensure_signed_in
    unless current_user
      store_requested_url
      redirect_to signin_path
    end
  end

  def store_requested_url
    session[:return_to] ||= request.fullpath
  end

  def store_previous_url
    session[:return_to] ||= request.referer
  end

  def redirect_back_or(default_path, options = {})
    redirect_to(session.delete(:return_to) || default_path, options)
  end
end
