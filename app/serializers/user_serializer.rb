class UserSerializer < ActiveModel::Serializer
  has_many :offers

  attributes :id, :email
end
