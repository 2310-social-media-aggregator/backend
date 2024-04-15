class FollowSerializer
    include JSONAPI::Serializer
    
    attributes  :user_id, 
                :creator_id
end