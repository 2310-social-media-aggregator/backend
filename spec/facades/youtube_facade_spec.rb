require 'rails_helper'

RSpec.describe 'YoutubeFacade' do 
    it 'get_channel' do
        stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCX6OQ3DkcsbYNE6H8uQQuVA&key=AIzaSyAcZts7iRvoRPoSKlXlAUoap3kZPlxz8pQ&maxResults=5&order=date&part=snippet&q=").
            with(
                headers: {
                    'Accept'=>'*/*',
                    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent'=>'Faraday v2.9.0'
                }).
        to_return(status: 200, body: File.read("spec/fixtures/MrBeast.json"), headers: {})

        channelId = 'UCX6OQ3DkcsbYNE6H8uQQuVA' # Mr Beast
        query = ''

        facade = YoutubeFacade.get_channel(channelId, query)

        expect(facade.count).to be > 1
        expect(facade[0]).to be_a(YoutubeVideoPoro)
        expect(facade[0].publishedAt).to eq("2024-03-16T16:00:00Z")
        expect(facade[0].title).to eq("Stop This Train, Win a Lamborghini")
        expect(facade[0].image).to eq("https://i.ytimg.com/vi/mKdjycj-7eE/hqdefault.jpg")
        expect(facade[0].id).to eq("mKdjycj-7eE")
    end
end