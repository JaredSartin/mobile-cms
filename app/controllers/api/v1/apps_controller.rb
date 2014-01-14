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
        finder = {}
        finder[:shortname] = params[:shortname]

        host = request.host
        host_match = host.match(/publicizr.com/)
        host_match = host.match(/example|127.0.0.1/) if Rails.env.test?
        host_match = host.match(/localhost|lvh.me/) if Rails.env.development?
        finder[:cname] = host unless !!host_match

        @apps = App.where(finder)
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

      def icon
        if @app.update_attributes(icon: params[:icon])
          render json: @app, serializer: AppSerializer
        end
      end

      private
      def app_params
        params.require(:app).permit(:name, :cname, :shortname, :homepage_id, :ga_key)
      end
    end
  end
end
