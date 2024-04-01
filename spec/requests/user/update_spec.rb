require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
    it "User Update" do
        user = User.create(name: 'TestName123abc', email: 'test@email.com')

        new_user_data = ({
            name: 'updated_name',
            email: 'updated@email.com'
        })
        patch "/api/v1/users/#{user.id}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_user_data)
        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        
        user = User.find_by(id: user.id)
        expect(user.name).to eq('updated_name')
        expect(user.email).to eq('updated@email.com')

        expect(json_response['data']['id']).to eq(user.id.to_s)
        expect(json_response['data']['attributes']['name']).to eq('updated_name')
        expect(json_response['data']['attributes']['email']).to eq('updated@email.com')
    end

    it "POST User Update [SAD]-name already in use" do
        user1 = User.create(name: 'TestName123abc', email: 'test@email.com')
        user2 = User.create(name: 'taken_name', email: 'taken@email.com')

        new_user_data = ({
            name: 'taken_name',
            email: 'taken@email.com'
        })

        patch "/api/v1/users/#{user1.id}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_user_data)
        expect(response).to have_http_status(409)
        json_response = JSON.parse(response.body)
        
        expect(json_response['error_object']['message']).to eq('Name taken.')
    end

    it "User Update [SAD]-blank name" do
        user = User.create(name: 'TestName123abc', email: 'test@email.com')

        new_user_data = ({
            name: ''
        })
        patch "/api/v1/users/#{user.id}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_user_data)
        expect(response).to have_http_status(406)
        json_response = JSON.parse(response.body)
        
        expect(json_response['error_object']['message']).to eq('No name given.')
    end

    it "User Update [SAD]-bogus id" do
        user = User.create(name: 'TestName123abc', email: 'test@email.com')

        new_user_data = ({
            name: 'Amongus'
        })
        patch "/api/v1/users/#{99999999}", headers: {"CONTENT_TYPE" => "application/json"}, params: JSON.generate(new_user_data)
        expect(response).to have_http_status(404)
        json_response = JSON.parse(response.body)
        
        expect(json_response['error_object']['message']).to eq('User not found.')
    end
end