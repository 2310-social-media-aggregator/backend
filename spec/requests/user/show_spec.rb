require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
    before(:each) do
        @user = User.create(name: "ur brand new stepdad!",
                            email: "quinnordmark@gmail.com")

        @MrBeast = Creator.create(name: "MrBeast")
        @PewDiePie = Creator.create(name: "PewDiePie")
        @Markiplier = Creator.create(name: "Markiplier")

        @follow1 = @user.follows.create(creator_id: @MrBeast.id)
        @follow2 = @user.follows.create(creator_id: @PewDiePie.id)
    end

    it 'can get every follow from show request' do
        get "/api/v1/users/#{@user.id}", headers: {"CONTENT_TYPE" => "application/json"}
        expect(response).to have_http_status(:success)
        json_response = JSON.parse(response.body)

        expect(json_response['data']['type']).to eq('user')
        expect(json_response['data']['id']).to eq(@user.id.to_s)
        expect(json_response['data']['attributes']['name']).to eq(@user.name)
    
        expect(json_response['data']['attributes']['follows'].count).to eq(2)
        expect(json_response['data']['attributes']['follows'].first['id']).to eq(@MrBeast.id)
        expect(json_response['data']['attributes']['follows'].first['name']).to eq(@MrBeast.name)
        expect(json_response['data']['attributes']['follows'].last['id']).to eq(@PewDiePie.id)
        expect(json_response['data']['attributes']['follows'].last['name']).to eq(@PewDiePie.name)
        expect(json_response['data']['attributes']['follows'].last['id']).to_not eq(@Markiplier.id)
    end
end