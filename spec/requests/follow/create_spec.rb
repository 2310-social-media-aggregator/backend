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
                    user_id: @user1.id,
                    creator_id: @creator2.id
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post "/api/v1/users/#{@user1.id}/follows", headers: headers, params: JSON.generate(follow_params)

                new_follow = Follow.last
                result = JSON.parse(response.body, symbolize_names: true)

                expect(response).to be_successful
                expect(response.status).to eq(201)

                expect(new_follow.user_id).to eq(follow_params[:user_id])
                expect(new_follow.creator_id).to eq(follow_params[:creator_id])

                # JSON formatting according to front end spec
                expect(result).to be_a(Hash)

                expect(result[:success]).to eq("Follow added successfully")
            end
        end

        describe "sad path" do
            it "errors out when user ID does not match existing users" do
                follow_params = {
                    user_id: 444,
                    creator_id: @creator2.id
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post "/api/v1/users/444/follows", headers: headers, params: JSON.generate(follow_params)

                result = JSON.parse(response.body, symbolize_names: true)

                expect(response).to_not be_successful
                expect(response.status).to eq(401)

                # JSON formatting according to front end spec
                expect(result).to be_a(Hash)

                expect(result[:error]).to eq("Sorry, your credentials are bad!")
            end

            it "errors out when creator ID does not match existing creators" do
                follow_params = {
                    user_id: @user1.id,
                    creator_id: 444
                }
                headers = { 
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }

                post "/api/v1/users/#{@user1.id}/follows", headers: headers, params: JSON.generate(follow_params)

                result = JSON.parse(response.body, symbolize_names: true)

                expect(response).to_not be_successful
                expect(response.status).to eq(401)

                # JSON formatting according to front end spec
                expect(result).to be_a(Hash)

                expect(result[:error]).to eq("Sorry, your credentials are bad!")
            end
        end
    end
end