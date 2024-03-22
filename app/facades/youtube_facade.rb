class YoutubeFacade

    def self.get_channel(handle, query)
        query = '' # delete this line if we are going to add search functionality

        youtube_service = YoutubeService.new
        youtube_json = youtube_service.get_channel(handle, query)
        youtube = []
        youtube_json[:items].each do |video|
            youtube.append(YoutubeVideoPoro.new(video))
        end

        {'videos': youtube}
    end
end