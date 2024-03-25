class Api::V1::FollowsController < ApplicationController
    def create
        follow = Follow.new(user_id: params[:user_id], creator_id: params[:creator_id])

        if follow.save
            render json: { success: "Follow added successfully" }, status: :created
        else
            render json: follow.errors, status: :bad_request
        end
    end
end

private

def follow_params
    params.permit(:user_id, :creator_id)
end