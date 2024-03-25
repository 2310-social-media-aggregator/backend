class TwitchFacade

    def self.get_channel(handle, query)
        query = '' # delete this line if we are going to add search functionality

        twitch_service = TwitchService.new
        twitch_json = twitch_service.get_channel(handle, query)
        twitch = []
        twitch_json[:data].each do |video|
            twitch.append(TwitchVideoPoro.new(video))
        end

        {'videos': twitch}
    end
end