module Api
  module V1
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :email, :first_name, :last_name, :links

      def links
        {
          apps: 'URL HERE'
        }
      end
    end
  end
end
