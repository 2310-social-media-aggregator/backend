require 'rails_helper'

RSpec.describe Follow do
    it { should validate_presence_of(:creator_id) }
    it { should belong_to(:user) }
end