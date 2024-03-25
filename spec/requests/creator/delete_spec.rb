require 'rails_helper'

RSpec.describe 'CreatorFacade' do 
    before(:each) do
        @JustinBieber = Creator.create(name: "Justin Bieber")
        @original_creator_count = Creator.all.count
    end

    it 'DELETE Creator Delete' do
        new_creator_data = ({'name': 'TestName123abc'})
        delete "/api/v1/creators/#{@JustinBieber.id}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_creator_data)
        expect(response).to have_http_status(204)

        expect(Creator.find_by(id: @JustinBieber.id)).to eq(nil)
        expect(Creator.all.count).to eq(@original_creator_count-1)
    end

    it 'DELETE Creator Delete - [SAD]-bad id' do
        delete "/api/v1/creators/#{999999999999999}", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(404)
        json_response = JSON.parse(response.body)

        expect(Creator.find_by(id: @JustinBieber.id)).to eq(@JustinBieber)
        expect(Creator.all.count).to eq(@original_creator_count)
        expect(Creator.last.name).to eq('Justin Bieber')

        expect(json_response['error_object']['message']).to eq('Creator not found.')
    end
end