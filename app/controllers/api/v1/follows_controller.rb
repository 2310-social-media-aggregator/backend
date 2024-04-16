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
        user = User.find_by(id: params[:user_id])
        if user != nil
            creator = Creator.find_by(id: params[:id])
            if creator != nil
                follow = user.follows.find_by(creator_id: creator.id)
                if follow != nil
                    if follow.destroy
                        render json: FollowSerializer.new(follow), status: :no_content
                    else
                        render json: ErrorSerializer.new(ErrorMessage.new("Follow delete failed.", 500)), status: :internal_server_error
                    end
                else
                    render json: ErrorSerializer.new(ErrorMessage.new("Follow not found.", 404)), status: :not_found
                end
            else
                render json: ErrorSerializer.new(ErrorMessage.new("Creator not found.", 404)), status: :not_found
            end
        else
            render json: ErrorSerializer.new(ErrorMessage.new("User not found.", 404)), status: :not_found
        end
    end
end
