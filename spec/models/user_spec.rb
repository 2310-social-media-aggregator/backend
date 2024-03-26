require 'rails_helper'

RSpec.describe User do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should have_many(:follows) }
end