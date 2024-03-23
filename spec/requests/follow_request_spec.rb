RSpec.describe "Api::V1::follow", type: :request do
    describe "Follow Create" do
        before :each do
            @user1 = User.create!(
                first_name: "General",
                last_name: "Iroh",
                email: "dragonofthewest@gmail.com",
                address: "123 Pi Cho Ct, Ba Sing Se"
                )

            @creator1 = Creator.create!(
                title: "Ginseng",
                description: "Ginseng has been used for improving overall health. It has also been used to strengthen the immune system and help fight off stress and disease.",
                temperature: "208°F",
                brew_time: "5 - 10 minutes"
            )
        end

        describe "happy path" do

        end
    end
end