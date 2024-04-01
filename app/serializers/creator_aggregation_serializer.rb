class CreatorAggregationSerializer
    include JSONAPI::Serializer

    attributes :name, :youtube_videos, :twitch_videos, :twitter
end