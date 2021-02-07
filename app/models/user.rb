class User < ApplicationRecord
  has_secure_password
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # has_secure_passwordがあるので、新規登録時は存在性の検証するため(nil)が有効にはならず、
  # 編集時は存在性が有効になるので、空のpasswordでも編集可能となる
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_many :favorites, dependent: :destroy
  has_many :umas, through: :favorites
  has_many :favorite_umas, through: :favorites, source: :umas
  
  has_many :parameters, dependent: :destroy
  has_many :couses, through: :couse_parameters
  has_many :couse_parameter_couses, through: :couse_parameters, source: :couses

  # has_many :myraces, dependent: :destroy
  # has_many :races, through: :myraces
  # has_many :couse_parameter_couses, through: :myraces, source: :races
end
