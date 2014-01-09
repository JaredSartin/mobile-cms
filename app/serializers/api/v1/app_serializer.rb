module Api
  module V1
    class AppSerializer < ActiveModel::Serializer
      attributes :id, :user_id, :homepage_id, :name, :cname, :shortname, :links, :icon_url

      def icon_url
        object.icon.url(:android)
      end

      def links
        {
          pages: pages_api_app_path(object)
        }
      end
    end
  end
end
