module Api
  module V1
    class AppSerializer < ActiveModel::Serializer
      attributes :id, :user_id, :name, :cname, :subdomain
    end
  end
end
