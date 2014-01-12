class UserDecorator < Draper::Decorator
  delegate_all

  def current_user?
    self == h.current_user
  end
end
