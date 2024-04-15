require 'rails_helper'

RSpec.describe 'Follow Delete' do 
    before(:each) do
        @user = User.create(name: "TestUserZYX987")
        @creator = Creator.create(name: "TestCreatorZYX987")
        @follow = @user.follows.create(creator_id: @creator.id)
    end

    it 'DELETE Follow [HAPPY]' do
        expect(Follow.find_by(id: @follow.id)).to_not eq(nil)

        delete "/api/v1/users/#{@user.id}/follows/#{@follow.id}", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(204)

        expect(Follow.find_by(id: @follow.id)).to eq(nil)
    end

    it 'DELETE Follow - [SAD]-bad follow id' do
        delete "/api/v1/users/#{@user.id}/follows/#{999999999999999}", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(404)
        json_response = JSON.parse(response.body)

        expect(json_response['error_object']['message']).to eq('Follow not found.')
    end

    it 'DELETE Follow - [SAD]-bad user id' do
        delete "/api/v1/users/#{999999999999999}/follows/#{@follow.id}", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(404)
        json_response = JSON.parse(response.body)

        expect(json_response['error_object']['message']).to eq('user.id does not equal follow.user_id.')
    end
end