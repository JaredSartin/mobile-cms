module Api
  module V1
    class PagesController < Api::ApplicationController
      load_resource :page

      def index
        if params["id"]
          @page = Page.find(params["id"])
          render json: @page, serializer: PageSerializer
        end
      end

      def show
        render json: @page, serializer: PageSerializer
      end

      def create
        @page = Page.new(page_params)
        if @page.save
          render json: @page, serializer: PageSerializer
        end
      end

      def update
        if @page.update_attributes(page_params)
          render json: @page, serializer: PageSerializer
        end
      end

      private
      def page_params
        params.require(:page).permit(:title, :body, :app_id, :order, :page_id)
      end
    end
  end
end
