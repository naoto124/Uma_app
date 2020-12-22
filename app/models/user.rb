class User < ApplicationRecord
  has_secure_password
  has_many :favorites, dependent: :destroy
  has_many :umas, through: :favorites
  has_many :favorite_umas, through: :favorites, source: :umas
  
  has_many :parameters, dependent: :destroy
  has_many :couses, through: :couse_parameters
  has_many :couse_parameter_couses, through: :couse_parameters, source: :couses
end
