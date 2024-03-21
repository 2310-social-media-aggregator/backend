require 'rails_helper'

RSpec.describe 'YoutubeFacade' do 
    it 'get_channel' do
        stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCX6OQ3DkcsbYNE6H8uQQuVA&key=#{Rails.application.credentials.youtube[:key]}&maxResults=5&order=date&part=snippet&q=").
            with(
                headers: {
                    'Accept'=>'*/*',
                    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent'=>'Faraday v2.9.0'
                }).
        to_return(status: 200, body: File.read("spec/fixtures/MrBeastYoutube.json"), headers: {})

        channelId = 'UCX6OQ3DkcsbYNE6H8uQQuVA' # Mr Beast
        query = ''

        facade = YoutubeFacade.get_channel(channelId, query)

        expect(facade[:videos].count).to be > 1
        expect(facade[:videos][0]).to be_a(YoutubeVideoPoro)
        expect(facade[:videos][0].publishedAt).to eq("2024-03-19T16:00:00Z")
        expect(facade[:videos][0].title).to eq("Keep Track Of Car, Win $10,000")
        expect(facade[:videos][0].image).to eq("https://i.ytimg.com/vi/OnTTThIzuNU/hqdefault.jpg")
        expect(facade[:videos][0].id).to eq("OnTTThIzuNU")
    end
end