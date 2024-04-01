require 'rails_helper'

RSpec.describe YoutubeService do
    it 'does Youtube Service correctly' do
        stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCX6OQ3DkcsbYNE6H8uQQuVA&key=#{Rails.application.credentials.youtube[:key]}&maxResults=5&order=date&part=snippet&q=").
                with(
                headers: {
                    'Accept'=>'*/*',
                    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent'=>'Faraday v2.9.0'
            }).
            to_return(status: 200, body: File.read("spec/fixtures/MrBeastYoutube.json"), headers: {})

        handle = 'UCX6OQ3DkcsbYNE6H8uQQuVA'

        youtube_service = YoutubeService.new
        json = youtube_service.get_channel(handle)

        expect(json[:items].count).to be > 0
        expect(json[:items].first[:snippet][:title].class).to eq(String)
        expect(json[:items].first[:snippet][:publishedAt].class).to eq(String)
        expect(json[:items].first[:snippet][:title].class).to eq(String)
        expect(json[:items].first[:snippet][:thumbnails][:high][:url].class).to eq(String)
    end
end