class Couse < ApplicationRecord
 validates :couse_name, {presence: true, uniqueness: true}

 has_many :couse_parameters, dependent: :destroy
 has_many :users, through: :couse_parameters
 accepts_nested_attributes_for :couse_parameters

 def couse_pltd(pl,t,d)
    Couse.find_by(place: pl, stage: t, distance: d)
 end

 def self.couse_find(user,couse)
   couses = Couse.find_by(id:couse)
   couse_parameter = couses.couse_parameters.find_by(user_id:user)
 end

 def self.couse_id(id)
   Couse.find_by(id:id)
 end

end
