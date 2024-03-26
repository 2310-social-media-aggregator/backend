class Api::V1::UsersController < ApplicationController
    def show
        user = User.find_by(id: params[:id])
        if user != nil
            facade = UserFacade.show(user)
            render json: UserSerializer.new(facade)
        else
            render json: ErrorSerializer.new(ErrorMessage.new("User not found.", 404)), status: :not_found
        end
    end
end