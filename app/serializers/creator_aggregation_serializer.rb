class CreatorAggregationSerializer
    include JSONAPI::Serializer
    set_id { nil }

    attribute :name do |object|
        object[:name]
    end

    attribute :youtube_videos do |object|
        object[:youtube_videos]
    end
end