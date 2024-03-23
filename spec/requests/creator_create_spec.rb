require "rails_helper"

RSpec.describe "Api::V1::creators", type: :request do
    it "POST Creator Create" do
        original_creator_count = Creator.all.count

        new_creator_data = ({
            'name': 'TestName123abc'
        })
        post "/api/v1/creators", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_creator_data)#(creator: new_creator_data)
        expect(response).to have_http_status(:201)
        json_response = JSON.parse(response.body)
        
        expect(Creator.all.count).to eq(original_creator_count+1)
        expect(Creator.last.name).to eq('TestName123abc')
        expect(Creator.last.youtube_handle).to eq(nil)
        expect(Creator.last.twitch_handle_handle).to eq(nil)
        expect(Creator.last.twitter_handle).to eq(nil)

        expect(json_response['data']['name']).to eq('TestName123abc')
        expect(json_response['data']['id']).to eq(Creator.last.id.to_s)
    end
end