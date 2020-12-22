class CouseParameter < ApplicationRecord
  belongs_to :user
  belongs_to :couse
  validates_uniqueness_of :couse_id, scope: :user_id

end
