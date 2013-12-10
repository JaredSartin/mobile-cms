module Api
  module V1
    class UsersController < Api::ApplicationController
      load_and_authorize_resource :user, find_by: :id

      def show
        render json: @user, serializer: UserSerializer
      end
    end
  end
end
