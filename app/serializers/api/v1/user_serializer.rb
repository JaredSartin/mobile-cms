module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email, :first_name, :last_name, :links

      def links
        {
          apps: apps_api_user_path(object)
        }
      end
    end
  end
end
