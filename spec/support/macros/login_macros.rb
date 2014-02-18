module LoginMacros
  def set_user_session(user)
    request.session[:user_id] = user.id
  end
end
