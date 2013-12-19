module Api
  module V1
    class AppsController < Api::ApplicationController
      load_resource :app

      def show
        render json: @app, serializer: AppSerializer
      end

      def pages
        render json: @app.pages, each_serializer: PageSerializer, root: 'pages'
      end
    end
  end
end
