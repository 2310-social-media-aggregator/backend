class CreatorAggregationPoro
    attr_reader :id,
                :name,
                :youtube_videos,
                :twitch_videos,
                :twitter

    def initialize(data)
        @id = data[:id]
        @name = data[:name]
        @youtube_videos = data[:youtube_videos]
        @twitch_videos = data[:twitch_videos]
        @twitter = data[:twitter]
    end

end