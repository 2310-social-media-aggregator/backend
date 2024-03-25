RSpec.describe "Api::V1::follow", type: :request do
    describe "Follow Create" do
        before :each do
            @user1 = User.create!(
                name: "Albert Wesker",
                email: "albertwesker@gmail.com"
                )

            @creator1 = Creator.create!(
                name: "MrBeast",
                youtube_handle: "pogorulab",
                twitch_handle: "pogorulab"
                )

            @creator2 = Creator.create!(
                name: "ZFG",
                youtube_handle: "donkus",
                twitch_handle: "blonkus"
                )
        end

        describe "happy path" do
            it "creates a follow" do
                follow_params = {
                    user_name: "Albert Wesker",
                    creator_name: "ZFG"
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post api_v1_follows_path, headers: headers, params: JSON.generate(follow_params)

                new_follow = Follow.last
                result = JSON.parse(response.body, symbolize_names: true)

                expect(response).to be_successful
                expect(response.status).to eq(201)

                expect(follow.user_id).to eq(follow_params[:user_id])
                expect(follow.creator_id).to eq(follow_params[:creator_id])

                # JSON formatting according to front end spec
                expect(result[:data]).to be_a(Hash)

                expect(result[:data][:id]).to eq("1")
                expect(result[:data][:type]).to eq("follow")

                # Exact attribute keys
                expect(result[:data][:attributes].count).to eq 2

                expect(result[:data][:attributes]).to have_key(:user_id)
                expect(result[:data][:attributes]).to have_key(:creator_id)

                expect(result[:data][:attributes][:user_id]).to be_a(Integer)
                expect(result[:data][:attributes][:creator_id]).to be_a(Integer)
                
                expect(result[:data][:attributes][:user_id]).to eq(1)
                expect(result[:data][:attributes][:creator_id]).to eq(2)
            end
        end
    end
end