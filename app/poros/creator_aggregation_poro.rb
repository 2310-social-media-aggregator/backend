class CreatorAggregationPoro
    attr_reader :id,
                :publishedAt,
                :title,
                :image

    def initialize(data)
        @id = data[:id]
        @name = data[:name]
        @youtube_videos = data[:youtube_videos]
        @twitch_videos = data[:twitch_videos]
    end
end