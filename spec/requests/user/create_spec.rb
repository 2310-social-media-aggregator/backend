require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
    it "POST User Create" do
        original_user_count = User.all.count

        new_user_data = ({
            name: 'TestName123abc',
            email: 'test@email.com'
        })
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_user_data)
        expect(response).to have_http_status(201)
        json_response = JSON.parse(response.body)
        
        expect(User.all.count).to eq(original_user_count+1)
        expect(User.last.name).to eq('TestName123abc')
        expect(User.last.email).to eq('test@email.com')

        expect(json_response['data']['id']).to eq(User.last.id.to_s)
        expect(json_response['data']['attributes']['name']).to eq('TestName123abc')
    end

    it "POST User Create [SAD]-name already in use" do
        new_user_data = ({
            name: 'TestName123abc',
            email: 'test@email.com'
        })

        # make new user with test data
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_user_data)
        expect(response).to have_http_status(201)

        original_user_count = User.all.count

        # make another user with same test data
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_user_data)
        expect(response).to have_http_status(409)
        json_response = JSON.parse(response.body)
        
        expect(User.all.count).to eq(original_user_count)

        expect(json_response['error_object']['message']).to eq('Name taken.')
    end

    it "POST User Create [SAD]-no name" do
        original_user_count = User.all.count
        new_user_data = ({
            email: 'test@email.com'
        })
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_user_data)
        expect(response).to have_http_status(406)
        json_response = JSON.parse(response.body)
        
        expect(User.all.count).to eq(original_user_count)
        expect(json_response['error_object']['message']).to eq('No name given.')
    end

    it "POST User Create [SAD]-blank name" do
        original_user_count = User.all.count
        new_user_data = ({
            name: '',
            email: 'test@email.com'
        })
        post "/api/v1/users", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_user_data)
        expect(response).to have_http_status(406)
        json_response = JSON.parse(response.body)
        
        expect(User.all.count).to eq(original_user_count)
        expect(json_response['error_object']['message']).to eq('No name given.')
    end
end