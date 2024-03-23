class User < ApplicationRecord

  validates :address, presence: true
end
