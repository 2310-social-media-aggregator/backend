class Creator < ApplicationRecord
    validates :name, presence: true, uniqueness: true
end