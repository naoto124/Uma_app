class Couse < ApplicationRecord
 validates :couse_name, {presence: true, uniqueness: true}

 has_many :couse_parameters, dependent: :destroy
 has_many :users, through: :couse_parameters
 accepts_nested_attributes_for :couse_parameters

 def couse_pltd(pl,t,d)
    Couse.find_by(place: pl, stage: t, distance: d)
 end
end
