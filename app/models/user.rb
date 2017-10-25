class User < ApplicationRecord
	tokify
	has_many :games, inverse_of :user, dependent: :destroy
end
