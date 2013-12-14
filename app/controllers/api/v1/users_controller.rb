module Api
  module V1
    class UsersController < Api::ApplicationController
      load_and_authorize_resource :user

      def show
        render json: @user, serializer: UserSerializer
      end

      def apps
        render json: @user.apps, each_serializer: AppSerializer, root: 'apps'
      end
    end
  end
end
