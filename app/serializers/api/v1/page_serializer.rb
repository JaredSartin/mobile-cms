module Api
  module V1
    class PageSerializer < ActiveModel::Serializer
      attributes :id, :app_id, :title, :body, :order
    end
  end
end
