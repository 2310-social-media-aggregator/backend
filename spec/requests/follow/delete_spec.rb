RSpec.describe "Api::V1::follow", type: :request do
    describe "Follow Delete" do
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

            @follow1 = @user1.follows.create!(
                creator_id: @creator2.id
            )
        end

        describe "happy path" do
            it "deletes a follow" do

                delete api_v1_user_follow_path(@user1.id, @follow1.id)

                expect(response.status).to eq(204)
                expect(Follow.count).to eq(0)
                expect{Follow.find(@follow1.id)}.to raise_error(ActiveRecord::RecordNotFound)
            end

            describe "sad path" do
                it 'returns a 401 if the follow does not exist' do
                  delete api_v1_user_follow_path(@user1.id, 444) 
            
                  expect(response.status).to eq(401)
                end
              end
        end
    end
end