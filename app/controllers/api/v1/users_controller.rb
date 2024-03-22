class Api::V1::UsersController < ApplicationController
    def show
        user = User.find(params[:id])
        facade = UserFacade.show(user)
        render json: UserShowSerializer.new(facade)
    end
end