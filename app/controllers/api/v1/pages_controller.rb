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

      def destroy
        if @page.destroy
          head 204
        end
      end

      def children
        children = current_user ? @page.children : @page.visible_children
        render json: children, each_serializer: PageSerializer
      end

      private
      def page_params
        params.require(:page).permit(:title, :body, :app_id, :order, :page_id, :parent_id, :start_date, :end_date)
      end
    end
  end
end
