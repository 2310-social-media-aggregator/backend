require 'rails_helper'

RSpec.describe 'Users' do 
    before(:each) do
        @JustinBieber = User.create(name: "Justin Bieber")
        @original_user_count = User.all.count
    end

    it 'DELETE User Delete' do
        user_data = ({'name': 'TestName123abc'})
        delete "/api/v1/users/#{@JustinBieber.id}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(user_data)
        expect(response).to have_http_status(204)

        expect(User.find_by(id: @JustinBieber.id)).to eq(nil)
        expect(User.all.count).to eq(@original_user_count-1)
    end

    it 'DELETE User Delete - [SAD]-bad id' do
        delete "/api/v1/users/#{999999999999999}", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(404)
        json_response = JSON.parse(response.body)

        expect(User.find_by(id: @JustinBieber.id)).to eq(@JustinBieber)
        expect(User.all.count).to eq(@original_user_count)
        expect(User.last.name).to eq('Justin Bieber')

        expect(json_response['error_object']['message']).to eq('User not found.')
    end
end