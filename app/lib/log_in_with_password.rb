class LogInWithPassword
  attr_reader :email, :password

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    @success = identity.authenticate(password).present?
  end

  def success?
    @success
  end

  def user
    User.find_by(email: email) || NullUser.new
  end

  def identity
    user.password_identity || NullIdentity.new
  end

  class NullUser
    def password_identity
      NullIdentity.new
    end
  end

  class NullIdentity
    def authenticate(_)
      false
    end
  end
end
