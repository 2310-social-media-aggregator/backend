require "rails_helper"

RSpec.describe "Api::V1::creators", type: :request do
    before(:each) do
        @MrBeast = Creator.create(name: "MrBeast")
        @PewDiePie = Creator.create(name: "PewDiePie")
        @Markiplier = Creator.create(name: "Markiplier")
        @jacksepticeye = Creator.create(name: "jacksepticeye")
    end

    it "GET Creator Index" do
        get "/api/v1/creators", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response['data']['type']).to eq('creator_index')
        expect(json_response['data']['attributes']['creators'].count).to eq(4)

        expect(json_response['data']['attributes']['creators'].first['name']).to eq(@MrBeast.name)
        expect(json_response['data']['attributes']['creators'].first['id']).to eq(@MrBeast.id)

        expect(json_response['data']['attributes']['creators'].last['name']).to eq(@jacksepticeye.name)
        expect(json_response['data']['attributes']['creators'].last['id']).to eq(@jacksepticeye.id)
    end
end