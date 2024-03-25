require "rails_helper"

RSpec.describe "Api::V1::creators", type: :request do
    before(:each) do
        @creator = Creator.create(name: 'MrBeast')
        @original_creator_count = Creator.all.count
    end

    it "PATCH Creator Update" do
        expect(Creator.all.count).to eq(@original_creator_count)
        expect(Creator.last.name).to eq('MrBeast')
        expect(Creator.last.youtube_handle).to eq(nil)
        expect(Creator.last.twitch_handle).to eq(nil)
        expect(Creator.last.twitter_handle).to eq(nil)

        new_creator_data = ({
            youtube_handle: 'UCX6OQ3DkcsbYNE6H8uQQuVA',
            twitch_handle: 'mrbeast6000',
            twitter_handle: 'MrBeast'
        })
        patch "/api/v1/creators/#{@creator.id}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_creator_data)
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        
        expect(Creator.all.count).to eq(@original_creator_count)
        expect(Creator.last.name).to eq('MrBeast')
        expect(Creator.last.youtube_handle).to eq('UCX6OQ3DkcsbYNE6H8uQQuVA')
        expect(Creator.last.twitch_handle).to eq('mrbeast6000')
        expect(Creator.last.twitter_handle).to eq('MrBeast')

        expect(json_response['data']['id']).to eq(Creator.last.id.to_s)
        expect(json_response['data']['attributes']['name']).to eq('MrBeast')
        expect(json_response['data']['attributes']['youtube_handle']).to eq('UCX6OQ3DkcsbYNE6H8uQQuVA')
        expect(json_response['data']['attributes']['twitch_handle']).to eq('mrbeast6000')
        expect(json_response['data']['attributes']['twitter_handle']).to eq('MrBeast')
    end

    it "PATCH Creator Update - [SAD]-bad id" do
        new_creator_data = ({
            youtube_handle: 'UCX6OQ3DkcsbYNE6H8uQQuVA',
            twitch_handle: 'mrbeast6000',
            twitter_handle: 'MrBeast'
        })
        patch "/api/v1/creators/#{99999999999999}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_creator_data)
        expect(response).to have_http_status(404)
        json_response = JSON.parse(response.body)
        
        expect(Creator.all.count).to eq(@original_creator_count)
        expect(Creator.last.name).to eq('MrBeast')
        expect(Creator.last.youtube_handle).to eq(nil)
        expect(Creator.last.twitch_handle).to eq(nil)
        expect(Creator.last.twitter_handle).to eq(nil)

        expect(json_response['error_object']['message']).to eq('Creator not found.')
    end 
end