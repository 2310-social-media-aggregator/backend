require 'rails_helper'

RSpec.describe 'CreatorFacade' do 
    before(:each) do
        @MrBeast = Creator.create(name: "MrBeast", youtube_handle: 'UCX6OQ3DkcsbYNE6H8uQQuVA')
        @PewDiePie = Creator.create(name: "PewDiePie")
        @Markiplier = Creator.create(name: "Markiplier")
        @jacksepticeye = Creator.create(name: "jacksepticeye")
    end

    it 'GET Creator Index' do
        get "/api/v1/creators", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)

        expect(json_response['data']['attributes']['creators'].count).to eq(4)
        expect(json_response['data']['attributes']['creators'][0]['name']).to eq('MrBeast')
        expect(json_response['data']['attributes']['creators'][0]['id']).to eq(@MrBeast.id)
        expect(json_response['data']['attributes']['creators'][1]['name']).to eq('PewDiePie')
        expect(json_response['data']['attributes']['creators'][1]['id']).to eq(@PewDiePie.id)
        expect(json_response['data']['attributes']['creators'][2]['name']).to eq('Markiplier')
        expect(json_response['data']['attributes']['creators'][2]['id']).to eq(@Markiplier.id)
        expect(json_response['data']['attributes']['creators'][3]['name']).to eq('jacksepticeye')
        expect(json_response['data']['attributes']['creators'][3]['id']).to eq(@jacksepticeye.id)
    end
end