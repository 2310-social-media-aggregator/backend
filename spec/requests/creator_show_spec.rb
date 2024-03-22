require "rails_helper"

RSpec.describe "Api::V1::creators", type: :request do
    before(:each) do
        @MrBeast = Creator.create(  name: "MrBeast",
                                    youtube_handle: "UCX6OQ3DkcsbYNE6H8uQQuVA")
    end

    xit "GET Creator Aggregation" do
        stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId=UCX6OQ3DkcsbYNE6H8uQQuVA&key=#{Rails.application.credentials.youtube[:key]}&maxResults=5&order=date&part=snippet&q=").
            with(
                headers: {
                    'Accept'=>'*/*',
                    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent'=>'Faraday v2.9.0'
                }).
        to_return(status: 200, body: File.read("spec/fixtures/MrBeastYoutube.json"), headers: {})

        get "/api/v1/creators/#{@MrBeast.id}", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response['data']['id']).to eq(@MrBeast.id.to_s)
        expect(json_response['data']['type']).to eq('creator')
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