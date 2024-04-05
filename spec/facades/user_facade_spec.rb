require 'rails_helper'

RSpec.describe 'UserFacade' do 
    before(:each) do
        @user = User.create(name: "test_user")
        @creator_1 = Creator.create(name: "test_creator_1")
        @creator_2 = Creator.create(name: "test_creator_2")
        @follow_1 = @user.follows.create(creator_id: @creator_1.id)
        @follow_2 = @user.follows.create(creator_id: @creator_2.id)
    end

    it 'show' do
        facade = UserFacade.show(@user)

        expect(facade.id).to eq(@user.id)
        expect(facade.name).to eq(@user.name)

        expect(facade.follows.count).to be > 1
        expect(facade.follows[0][:id]).to eq(@creator_1.id)
        expect(facade.follows[0][:name]).to eq(@creator_1.name)
        expect(facade.follows[1][:id]).to eq(@creator_2.id)
        expect(facade.follows[1][:name]).to eq(@creator_2.name)
    end
end