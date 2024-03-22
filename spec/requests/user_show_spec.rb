require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
    before(:each) do
        @user = User.create(name: "ur brand new stepdad!",
                            email: "quinnordmark@gmail.com")

        @MrBeast = Creator.create(  name: "MrBeast",
                                    youtube_handle: "UCX6OQ3DkcsbYNE6H8uQQuVA")
    end
end