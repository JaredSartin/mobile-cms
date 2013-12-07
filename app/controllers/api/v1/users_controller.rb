module Api
  module V1
    class UsersController < Api::ApplicationController
      def show
        render json: current_user#, serializer: UserSerializer
      end
    end
  end
end
