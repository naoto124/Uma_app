class User < ApplicationRecord
  has_secure_password
  has_many :favorites, dependent: :destroy
  has_many :umas, through: :favorites
  has_many :favorite_umas, through: :favorites, source: :umas
end
