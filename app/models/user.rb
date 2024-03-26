class User < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    has_many :follows
end