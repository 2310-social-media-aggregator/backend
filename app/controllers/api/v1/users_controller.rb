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

    def create
        if params[:name] != nil && params[:name] != ''
            if User.find_by(name: params[:name]) == nil
                user = User.create(user_params)
                if user.save
                    render json: UserSerializer.new(user), status: :created
                else
                    render json: ErrorSerializer.new(ErrorMessage.new("Save failed.", 500)), status: :internal_server_error
                end
            else
                render json: ErrorSerializer.new(ErrorMessage.new("Name taken.", 409)), status: :conflict
            end
        else
            render json: ErrorSerializer.new(ErrorMessage.new("No name given.", 406)), status: :not_acceptable
        end
    end

    def destroy
        user = User.find_by(id: params[:id])
        if user != nil
            if user.destroy
                render json: UserSerializer.new(user), status: :no_content
            else
                render json: ErrorSerializer.new(ErrorMessage.new("Delete failed.", 500)), status: :internal_server_error
            end
        else
            render json: ErrorSerializer.new(ErrorMessage.new("User not found.", 404)), status: :not_found
        end
    end

    def update
        user = User.find_by(id: params[:id])
        if params[:name] == ''
            render json: ErrorSerializer.new(ErrorMessage.new("No name given.", 406)), status: :not_acceptable
        elsif user != nil
            if User.find_by(name: params[:name]) == nil
                if user.update(user_params)
                    render json: UserSerializer.new(user), status: :ok
                else
                    render json: ErrorSerializer.new(ErrorMessage.new("Update failed.", 500)), status: :internal_server_error
                end
            else
                render json: ErrorSerializer.new(ErrorMessage.new("Name taken.", 409)), status: :conflict
            end
        else
            render json: ErrorSerializer.new(ErrorMessage.new("User not found.", 404)), status: :not_found
        end
    end

    private

    def user_params
        params.permit(  :id, 
                        :name, 
                        :email)
    end
end