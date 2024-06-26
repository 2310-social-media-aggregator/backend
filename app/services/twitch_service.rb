class TwitchService
    def conn
        Faraday.new(url: 'https://api.twitch.tv/helix') do |faraday|
          faraday.headers['Authorization'] = "Bearer #{Rails.application.credentials.twitch[:bearer_token]}"
          faraday.headers['Client-Id'] = Rails.application.credentials.twitch[:client_id] 
          #faraday.headers['X-Api-Key'] = Rails.application.credentials.api_ninjas[:key]
        end
    end
    
    def get_url(url)
        response = conn.get(url) 
        JSON.parse(response.body, symbolize_names: true)
    end
    
    def get_channel(handle)
        max_results = 5
        query = '' # delete this line if we are going to add search functionality
        get_url("https://api.twitch.tv/helix/videos?user_id=#{handle}&first=#{max_results}")
    end
end