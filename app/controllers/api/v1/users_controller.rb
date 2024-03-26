class Api::V1::UsersController < ApplicationController
    def show
        user = User.find(params[:id])
        facade = UserFacade.show(user)
        render json: UserSerializer.new(facade)
    end
end