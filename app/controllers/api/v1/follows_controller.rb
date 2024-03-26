class Api::V1::FollowsController < ApplicationController
    def create
        user = find_user_by_id(params[:user_id])
        creator = find_creator_by_id(params[:creator_id])
        follow = user.follows.new(creator_id: creator.id)

        if follow.save
            render json: { success: "Follow added successfully" }, status: :created
        else
            render json: follow.errors, status: :bad_request
        end
    end

    def destroy
        follow = find_follow_by_id(params[:id])

        follow.destroy
        head :no_content # sends a 204 no content response
    end
end

private

def follow_params
    params.permit(:user_id, :creator_id)
end