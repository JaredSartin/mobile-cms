module Api
  module V1
    class PageSerializer < ActiveModel::Serializer
      attributes :id, :app_id, :title, :content, :order
    end
  end
end
