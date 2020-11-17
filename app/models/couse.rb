class Couse < ApplicationRecord
 validates :couse_name, {presence: true, uniqueness: true}
 def self.couse_get
    couses =[

    東京 = ["東京 芝 1400","東京 芝 1600","東京 芝 1800","東京 芝 2000",
            "東京 芝 2300","東京 芝 2400","東京 芝 2500","東京 芝 3400",
            "東京 ダート 1300","東京 ダート 1400","東京 ダート 1600","東京 ダート 2100","東京 ダート 2400"],
    
    京都 = ["京都 芝 1200","京都 芝 1400 (内)","京都 芝 1400 (外)","京都 芝 1600 (内)",
            "京都 芝 1600 (内)","京都 芝 1600 (外)","京都 芝 1800","京都 芝 2400","京都 芝 3000","京都 芝 3200",
            "京都 ダート 1200","京都 ダート 1400","京都 ダート 1800","京都 ダート 1900"],
    
    阪神 = ["阪神 芝 1200","阪神 芝 1400","阪神 芝 1600","阪神 芝 1800","阪神 芝 2000",
            "阪神 芝 2200","阪神 芝 2400","阪神 芝 3000",
            "阪神 ダート 1200","阪神 ダート 1400","阪神 ダート 1800","阪神 ダート 2000"],
    
    中京 = ["中京 芝 1200","中京 芝 1400","中京 芝 1600","中京 芝 2000","中京 芝 2200",
            "中京 ダート 1200","中京 ダート 1400","中京 ダート 1800","中京 ダート 1900"],

    札幌 =["札幌 芝 1200","札幌 芝 1500","札幌 芝 1800","札幌 芝 2000","札幌 芝 2600",
            "札幌 ダート 1000","札幌 ダート 1700","札幌 ダート 2400"],
    
    函館 = ["函館 芝 1200","函館 芝 1800","函館 芝 2000","函館 芝 2600",
            "函館 ダート 1000","函館 ダート 1700","函館 ダート 2400"],
    
    福島 =["福島 芝 1200","福島 芝 1700","福島 芝 1800","福島 芝 2000","福島 芝 2600",
            "福島 ダート 1000","福島 ダート 1150","福島 ダート 1700","福島 ダート 2400"],
    
    新潟 = ["新潟 芝 1000","新潟 芝 1200","新潟 芝 1400","新潟 芝 1600","新潟 芝 1800",
            "新潟 芝 2000 (内)","新潟 芝 2000 (外)","新潟 芝 2200","新潟 芝 2400",
            "新潟 ダート 1200","新潟 ダート 1800"],
    
    中山 = ["中山 芝 1200","中山 芝 1600","中山 芝 1800","中山 芝 2000",
            "中山 芝 2200","中山 芝 2500","中山 芝 3600",
            "中山 ダート 1200","中山 ダート 1800","中山 ダート 2400","中山 ダート 2500"],
    
    小倉 = ["小倉 芝 1200","小倉 芝 1700","小倉 芝 1800","小倉 芝 2000","小倉 芝 2600",
            "小倉 ダート 1000","小倉 ダート 1700","小倉 ダート 2400"],
    ]

    couse_name = []
    uniq_couse =[]


    couses.each do |couse|
      couse.each do |c|
        couse_name << c
      end
    end

    couse_name.each do |couse|
      couse.split.each do |c|
        uniq_couse << c
        uniq_couse = uniq_couse.uniq
      end
    end

    # couse_name.each do |n|
    #   c = Couse.new()
    #   c.couse_name = n
    #   c.save
    # end
    couse_name_date = Couse.pluck(:couse_name)

      couse_name_date.each do |d|
        uniq_couse.each do |q|
          if d.split[0] == q
            c = Couse.find_by(couse_name: d)
              c.place = d
            c.save
          end
        end
      end

      couse_name_date.each do |d|
        uniq_couse.each do |q|
          if d.split[1] == q
            c = Couse.find_by(couse_name: d)
              c.type = d
            c.save
          end
        end
      end

      couse_name_date.each do |d|
        uniq_couse.each do |q|
          if d.split[2] == q
            c = Couse.find_by(couse_name: d)
              c.distance = d
            c.save
          end
        end
      end
      


  
    #   couse_name.each do |c|
    #    uniq_couse.each do |q|
    #    if c.split[1] == q
    #      p q
    #    end
    #   end
    #  end
    
    #   couse_name.each do |c|
    #    uniq_couse.each do |q|
    #    if c.split[2] == q
    #      p q
    #    end
    #   end
    #  end
  end

  # def self.p_t_d(te)
#     couse_name_date = Couse.pluck(:couse_name)
#     ptd =["place","type","distance"]

#     couse_name_date.each do |d|
#       @uniq_couse.each do |q|
#         if d.split[(te)] == q
#           c = Couse.find_by(couse_name: d)
#           if (te) == 0
#             c.ptd[0] = d
#             elsif (te) == 1
#             c.ptd[1] = d
#             elsif (te) == 2
#             c.ptd[2] = d
#           end
#           c.save
#         end
#       end
#     end
#  end

end
