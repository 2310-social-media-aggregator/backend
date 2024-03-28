require "rails_helper"

RSpec.describe "Api::V1::creators", type: :request do
    describe "YouTube content" do
        before(:each) do
            @MrBeast = Creator.create(  name: "MrBeast",
                                        youtube_handle: "UCX6OQ3DkcsbYNE6H8uQQuVA")
    
            stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCX6OQ3DkcsbYNE6H8uQQuVA&key=#{Rails.application.credentials.youtube[:key]}&maxResults=5&order=date&part=snippet&q=").
                with(
                headers: {
                    'Accept'=>'*/*',
                    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent'=>'Faraday v2.9.0'
            }).
            to_return(status: 200, body: File.read("spec/fixtures/MrBeastYoutube.json"), headers: {})
        end
    
        it "GET YouTube Creator Aggregation" do
            get "/api/v1/creators/#{@MrBeast.id}", headers: {"CONTENT_TYPE" => "application/json"}
            expect(response).to have_http_status(:success)
            json_response = JSON.parse(response.body)
    
            expect(json_response['data']['id']).to eq(@MrBeast.id.to_s)
            expect(json_response['data']['type']).to eq('creator_aggregation')
            expect(json_response['data']['attributes']['name']).to eq('MrBeast')
    
            expect(json_response['data']['attributes']['youtube_videos'].count).to eq(5)
        
            expect(json_response['data']['attributes']['youtube_videos'].first['title']).to eq('Keep Track Of Car, Win $10,000')
            expect(json_response['data']['attributes']['youtube_videos'].first['image']).to eq('https://i.ytimg.com/vi/OnTTThIzuNU/hqdefault.jpg')
            expect(json_response['data']['attributes']['youtube_videos'].first['id']).to eq('OnTTThIzuNU')
            expect(json_response['data']['attributes']['youtube_videos'].first['publishedAt']).to eq('2024-03-19T16:00:00Z')
    
            expect(json_response['data']['attributes']['youtube_videos'].last['id']).to eq('AFXoSFNMwIA')
            expect(json_response['data']['attributes']['youtube_videos'].last['title']).to eq("I Filled Chandler’s Car With Feastables")
        end
    end

    describe "Twitch content" do
        before(:each) do
            @zfg = Creator.create(  name: "ZFG",
                                    twitch_handle: "8683614")
                                   
             stub_request(:get, "https://api.twitch.tv/helix/videos?first=5&user_id=8683614?").
             with(
                 headers: {
                 'Accept'=>'*/*',
                 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                 'User-Agent'=>'Faraday v2.9.0'
                 }).
            to_return(status: 200, body: File.read("spec/fixtures/ZFGTwitch.json"), headers: {})
        end

        it "GET Twitch Creator Aggregation" do
            get "/api/v1/creators/#{@zfg.id}", headers: {"CONTENT_TYPE" => "application/json"}
            expect(response).to have_http_status(:success)

            result = JSON.parse(response.body, symbolize_names: true)
    
            expect(result[:data][:type]).to eq('creator_aggregation')
            expect(result[:data][:attributes][:name]).to eq('ZFG')
    
            expect(result[:data][:attributes][:twitch_videos].count).to eq(5)

            expect(result[:data][:attributes][:twitch_videos][0]).to have_key(:id)
            expect(result[:data][:attributes][:twitch_videos][0]).to have_key(:title)
            expect(result[:data][:attributes][:twitch_videos][0]).to have_key(:published_at)
            expect(result[:data][:attributes][:twitch_videos][0]).to have_key(:image)

            expect(result[:data][:attributes][:twitch_videos][0][:id]).to be_a(String)
            expect(result[:data][:attributes][:twitch_videos][0][:title]).to be_a(String)
            expect(result[:data][:attributes][:twitch_videos][0][:published_at]).to be_a(String)
            expect(result[:data][:attributes][:twitch_videos][0][:image]).to be_a(String)

            expect(result[:data][:attributes][:twitch_videos][0][:id]).to eq("2100415767")
            expect(result[:data][:attributes][:twitch_videos][0][:title]).to eq("Majora's Mask Randomizer - No Logic and no starting items")
            expect(result[:data][:attributes][:twitch_videos][0][:published_at]).to eq("2024-03-24T19:54:27Z")
            expect(result[:data][:attributes][:twitch_videos][0][:image]).to eq("https://vod-secure.twitch.tv/_404/404_processing_%{width}x%{height}.png")

            expect(result[:data][:attributes][:twitch_videos][4][:id]).to eq("2092737221")
            expect(result[:data][:attributes][:twitch_videos][4][:title]).to eq("Majora's Mask Randomizer with everything randomized")
            expect(result[:data][:attributes][:twitch_videos][4][:published_at]).to eq("2024-03-16T19:53:15Z")
            expect(result[:data][:attributes][:twitch_videos][4][:image]).to eq("https://static-cdn.jtvnw.net/cf_vods/d1m7jfoe9zdc1j/31ff66e0be8089e26863_zfg1_50648550989_1710618791//thumb/thumb0-%{width}x%{height}.jpg")
        end
    end
end