require 'rails_helper'

RSpec.describe Creator do
    it { should validate_presence_of(:name) }
end