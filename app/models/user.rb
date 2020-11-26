class User < ApplicationRecord
  has_secure_password
  has_many :favorite, dependent: :destroy
  has_many :uma, through: :favorite
end
