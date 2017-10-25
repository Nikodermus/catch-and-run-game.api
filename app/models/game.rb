class Game < ApplicationRecord
  belongs_to :user, inverse_of :games

  enum difficulty: %w(easy normal hard)
end
