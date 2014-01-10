module Api
  module V1
    class AppSerializer < ActiveModel::Serializer
      attributes :id, :user_id, :homepage_id, :name, :cname, :shortname,
        :apple_smallest_icon, :apple_small_icon, :apple_medium_icon,
        :apple_large_icon, :android_icon, :links

      ICON_TYPES = [:apple_smallest, :apple_small, :apple_medium, :apple_large, :android]
      ICON_TYPES.each do |type|
        method_name = "#{type.to_s}_icon"
        define_method method_name do
          type = :original if Rails.env.test?
          object.icon.url(type)
        end
      end

      def links
        {
          pages: pages_api_app_path(object)
        }
      end
    end
  end
end
