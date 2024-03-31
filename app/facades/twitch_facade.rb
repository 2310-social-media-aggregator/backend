class TwitchFacade

    def self.get_channel(handle)
        query = '' # delete this line if we are going to add search functionality

        twitch_service = TwitchService.new
        twitch_json = twitch_service.get_channel(handle)
        twitch = []
        twitch_json[:data].each do |video|
            twitch.append(TwitchVideoPoro.new(video))
        end

        {'videos': twitch}
    end

    def self.cache_get_channel(handle)
     
        cache_key = "twitch_#{handle}"
        Rails.cache.fetch(cache_key, expires_in: 1.hours) do
  
          get_channel(handle)
        end
      
    end
end