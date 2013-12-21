module Api
  module V1
    class PagesController < Api::ApplicationController
      def create
        @page = Page.new(page_params)
        if @page.save
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
