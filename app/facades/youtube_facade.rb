class YoutubeFacade

    def self.get_channel(channelId, query)
        query = '' # delete this line if we are going to add search functionality

        youtube_service = YoutubeService.new
        youtube_json = youtube_service.get_channel(channelId, query)
        youtube = {}
        if youtube_json[:items].count > 0
            youtube = YoutubeVideoPoro.new(youtube_json[:items])
        end

        {'videos': youtube}
    end
end