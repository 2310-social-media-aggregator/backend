class YoutubeFacade

    def self.get_channel(handle)
        query = '' # delete this line if we are going to add search functionality
        youtube_service = YoutubeService.new
        youtube_json = youtube_service.get_channel(handle)
        youtube = []
        youtube_json[:items].each do |video|
            youtube.append(YoutubeVideoPoro.new(video))
        end

        {'videos': youtube}
    end

    def self.cache_get_channel(handle)
     
      cache_key = "youtube_#{handle}"
      Rails.cache.fetch(cache_key, expires_in: 1.hours) do

        get_channel(handle)
      end
    
    end

end


