module Api
  module V1
    class AppsController < Api::ApplicationController
      load_resource :app

      # def create
      #   @app = App.new(app_params)
      #   if @app.save
      #     render json: @app, serializer: AppSerializer
      #   end
      # end

      def update
        if @app.update_attributes(app_params)
          render json: @app, serializer: AppSerializer
        end
      end

      def show
        render json: @app, serializer: AppSerializer
      end

      def pages
        render json: @app.pages, each_serializer: PageSerializer, root: 'pages'
      end

      private
      def app_params
        params.require(:app).permit(:name, :cname, :subdomain, :homepage_id)
      end
    end
  end
end
