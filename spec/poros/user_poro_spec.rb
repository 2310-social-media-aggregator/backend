require 'rails_helper'

RSpec.describe UserPoro do
    it 'creates an User Poro based on attributes' do
        attr = {
            :id=>1872, 
            :name=>"test_user", 
            :follows=>[
                {
                    :id=>5846, 
                    :name=>"test_creator_1"
                },
                {
                    :id=>5847, 
                    :name=>"test_creator_2"
                }
            ]
        }

        poro = UserPoro.new(attr)
        expect(poro).to be_a(UserPoro)
        expect(poro.id).to eq(1872)
        expect(poro.name).to eq("test_user")
        expect(poro.follows.count).to eq(2)
        expect(poro.follows.first[:id]).to eq(5846)
        expect(poro.follows.first[:name]).to eq("test_creator_1")
    end
end