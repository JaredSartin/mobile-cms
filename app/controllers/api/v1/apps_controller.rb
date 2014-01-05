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
      
      def index
        @apps = App.where(shortname: params[:shortname])
        render json: @apps, each_serializer: AppSerializer
      end

      def update
        # needs cancan
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
        params.require(:app).permit(:name, :cname, :shortname, :homepage_id)
      end
    end
  end
end
