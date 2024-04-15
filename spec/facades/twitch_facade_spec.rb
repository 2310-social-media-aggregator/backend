require 'rails_helper'

RSpec.describe 'TwitchFacade' do 
    describe 'get_channel' do
        it "returns a Twitch service facade" do
            stub_request(:get, "https://api.twitch.tv/helix/videos?first=5&user_id=8683614").
            with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>"Bearer #{Rails.application.credentials.twitch[:bearer_token]}",
            'Client-Id'=>Rails.application.credentials.twitch[:client_id],
            'User-Agent'=>'Faraday v2.9.0'
            }).
            to_return(status: 200, body: File.read("spec/fixtures/ZFGTwitch.json"), headers: {})

            channel_id = '8683614' # ZFG

            facade = TwitchFacade.get_channel(channel_id)

            expect(facade[:videos].count).to be > 1
            expect(facade[:videos][0]).to be_a(TwitchVideoPoro)
            expect(facade[:videos][0].published_at).to eq("2024-03-24T19:54:27Z")
            expect(facade[:videos][0].title).to eq("Majora's Mask Randomizer - No Logic and no starting items")
            expect(facade[:videos][0].image).to eq("https://vod-secure.twitch.tv/_404/404_processing_%{width}x%{height}.png")
            expect(facade[:videos][0].id).to eq("2100415767")
        end
    end
end