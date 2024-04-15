require 'rails_helper'

RSpec.describe TwitchService do
    describe "get channel" do
        before :each do
            @zfg = Creator.create(  
                name: "ZFG",
                twitch_handle: "8683614"
            
                )
            stub_request(:get, "https://api.twitch.tv/helix/videos?first=5&user_id=8683614").
             with(
                 headers: {
                 'Accept'=>'*/*',
                 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'User-Agent'=>'Faraday v2.9.0'
                 }).
            to_return(status: 200, body: File.read("spec/fixtures/ZFGTwitch.json"), headers: {})

            handle = '8683614'

            twitch_service = TwitchService.new
            @json = twitch_service.get_channel(handle)
        end

        it 'returns 5 Twitch videos from specified channel' do
            expect(@json[:data].count).to be > 0

            expect(@json[:data].first[:id]).to be_a String
            expect(@json[:data].first[:title]).to be_a String
            expect(@json[:data].first[:published_at]).to be_a String
            expect(@json[:data].first[:thumbnail_url]).to be_a String

            expect(@json[:data].first[:id]).to eq "2100415767"
            expect(@json[:data].first[:title]).to eq "Majora's Mask Randomizer - No Logic and no starting items"
            expect(@json[:data].first[:published_at]).to eq "2024-03-24T19:54:27Z"
            expect(@json[:data].first[:thumbnail_url]).to eq "https://vod-secure.twitch.tv/_404/404_processing_%{width}x%{height}.png"
        end
    end
end