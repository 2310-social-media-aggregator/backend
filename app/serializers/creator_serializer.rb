class CreatorSerializer
    include JSONAPI::Serializer
    
    attributes  :name, 
                :youtube_handle,
                :twitch_handle,
                :twitter_handle
end