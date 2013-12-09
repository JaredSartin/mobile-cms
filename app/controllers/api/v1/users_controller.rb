module Api
  module V1
    class UsersController < Api::ApplicationController
      def show
        if params[:id] =~ /current/
          if current_user
            render json: current_user, serializer: UserSerializer
          else
            head 401
          end
        else
        end
      end
    end
  end
end
