class Api::V1::CreatorsController < ApplicationController
    def show
        user = User.find(params[:id])
        facade = UserFacade.show(user)
        render json: UserShowSerializer.new(facade)
    end
end