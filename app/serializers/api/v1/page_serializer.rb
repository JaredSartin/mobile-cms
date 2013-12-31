module Api
  module V1
    class PageSerializer < ActiveModel::Serializer
      attributes :id, :app_id, :title, :body, :order, :page_id, :links

      def links
        {
          children: children_api_page_path(object)
        }
      end
    end
  end
end
