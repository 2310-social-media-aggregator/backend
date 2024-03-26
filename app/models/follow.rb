class Follow < ApplicationRecord
    belongs_to :user
    validates :creator_id, presence: true
end