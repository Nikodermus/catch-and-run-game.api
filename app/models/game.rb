class Game < ApplicationRecord
  belongs_to :user
  enum difficulty: %w(easy normal hard)
end
