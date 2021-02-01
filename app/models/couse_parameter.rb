class CouseParameter < ApplicationRecord
  belongs_to :user
  belongs_to :couse
  validates_uniqueness_of :couse_id, scope: :user_id

  def couse_parameter_user(user)
    CouseParameter.where(user_id: user)
  end
end
