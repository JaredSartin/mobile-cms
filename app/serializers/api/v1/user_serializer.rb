module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email, :first_name, :last_name
    end
  end
end
