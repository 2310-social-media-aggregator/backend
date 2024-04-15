class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response 

    def not_found_response
        render json: { error: 'Sorry, your credentials are bad!' }, status: :unauthorized
    end

    # AR helpers

    def find_user_by_id(id)
        if user = User.find_by(id: id)
            user
        else
            raise ActiveRecord::RecordNotFound
        end
    end

    def find_creator_by_id(id)
        if creator = Creator.find_by(id: id)
            creator
        else
            raise ActiveRecord::RecordNotFound
        end
    end

    def find_follow_by_id(id)
        if follow = Follow.find(id)
            follow
        end
    end
end
