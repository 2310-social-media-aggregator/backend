class Api::V1::FollowsController < ApplicationController
    def create
        user = find_user_by_id(params[:user_id])
        creator = find_creator_by_id(params[:creator_id])
        follow = user.follows.new(creator_id: creator.id)

        if follow.save
            render json: { success: "Follow added successfully" }, status: :created
        end
    end

    def destroy
        follow = Follow.find_by(id: params[:id])
        if follow != nil
            if follow.user_id == params[:user_id].to_i
                if follow.destroy
                    render json: FollowSerializer.new(follow), status: :no_content
                else
                    render json: ErrorSerializer.new(ErrorMessage.new("Follow delete failed.", 500)), status: :internal_server_error
                end
            else
                render json: ErrorSerializer.new(ErrorMessage.new("user.id does not equal follow.user_id.", 404)), status: :not_found
            end
        else
            render json: ErrorSerializer.new(ErrorMessage.new("Follow not found.", 404)), status: :not_found
        end
    end
end
