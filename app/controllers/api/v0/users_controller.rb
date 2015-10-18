module Api
  module V0
    class UsersController < ActionController::Base
      def show
        user = User.find(params[:id])

        render json: user, include: "offers"
      end
    end
  end
end
