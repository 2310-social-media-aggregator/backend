class YoutubeService
    def conn
        Faraday.new(url: 'https://www.googleapis.com') do |faraday|
            #faraday.headers['X-Api-Key'] = Rails.application.credentials.api_ninjas[:key]
        end
    end
    
    def get_url(url)
        response = conn.get(url) 
        
        JSON.parse(response.body, symbolize_names: true)
    end
    
    def get_channel(handle)
        maxResults = 5
        query = '' # delete this line if we are going to add search functionality
        get_url("/youtube/v3/search?key=#{Rails.application.credentials.youtube[:key]}&q=#{query}&part=snippet&channelId=#{handle}&order=date&maxResults=#{maxResults}")
    end
end