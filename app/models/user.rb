class User < ApplicationRecord
	has_many :games, inverse_of: 'user', dependent: :destroy
	validates :password, length:{
		in: 8..12
	}
	validates :email, uniqueness: true, format: {
		with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
		message: 'Invalid format'
	}
	validates :nickname, length:{
		in: 4..12
	}
	has_secure_password
	tokify
end
