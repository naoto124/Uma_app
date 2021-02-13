# coding: utf-8
# load(Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb"))
  require 'mechanize'

# couseレコード
def couses

  couses =[
  
      "東京 芝 1400","東京 芝 1600","東京 芝 1800","東京 芝 2000",
              "東京 芝 2300","東京 芝 2400","東京 芝 2500","東京 芝 3400",
              "東京 ダート 1300","東京 ダート 1400","東京 ダート 1600","東京 ダート 2100","東京 ダート 2400",
      
      "京都 芝 1200","京都 芝 1400 (内)","京都 芝 1400 (外)","京都 芝 1600 (内)",
              "京都 芝 1600 (外)","京都 芝 1800","京都 芝 2200","京都 芝 2400","京都 芝 3000","京都 芝 3200",
              "京都 ダート 1200","京都 ダート 1400","京都 ダート 1800","京都 ダート 1900",
      
      "阪神 芝 1200","阪神 芝 1400","阪神 芝 1600","阪神 芝 1800","阪神 芝 2000",
              "阪神 芝 2200","阪神 芝 2400","阪神 芝 3000",
              "阪神 ダート 1200","阪神 ダート 1400","阪神 ダート 1800","阪神 ダート 2000",
      
      "中京 芝 1200","中京 芝 1400","中京 芝 1600","中京 芝 2000","中京 芝 2200",
              "中京 ダート 1200","中京 ダート 1400","中京 ダート 1800","中京 ダート 1900",
  
      "札幌 芝 1200","札幌 芝 1500","札幌 芝 1800","札幌 芝 2000","札幌 芝 2600",
              "札幌 ダート 1000","札幌 ダート 1700","札幌 ダート 2400",
      
      "函館 芝 1200","函館 芝 1800","函館 芝 2000","函館 芝 2600",
              "函館 ダート 1000","函館 ダート 1700","函館 ダート 2400",
      
      "福島 芝 1200","福島 芝 1700","福島 芝 1800","福島 芝 2000","福島 芝 2600",
              "福島 ダート 1000","福島 ダート 1150","福島 ダート 1700","福島 ダート 2400",
      
      "新潟 芝 1000","新潟 芝 1200","新潟 芝 1400","新潟 芝 1600","新潟 芝 1800",
              "新潟 芝 2000 (内)","新潟 芝 2000 (外)","新潟 芝 2200","新潟 芝 2400",
              "新潟 ダート 1200","新潟 ダート 1800",
      
      "中山 芝 1200","中山 芝 1600","中山 芝 1800","中山 芝 2000",
              "中山 芝 2200","中山 芝 2500","中山 芝 3600",
              "中山 ダート 1200","中山 ダート 1800","中山 ダート 2400","中山 ダート 2500",
      
      "小倉 芝 1200","小倉 芝 1700","小倉 芝 1800","小倉 芝 2000","小倉 芝 2600",
              "小倉 ダート 1000","小倉 ダート 1700","小倉 ダート 2400"
      ]
      p couses
      id以外
      couses.each do |e|
        Couse.create(
        couse_name: e,
        place: e.split[0],
        stage: e.split[1],
        distance: e.split[2],
        )
          end
  
      couses.each do |e|
        r = Couse.find_by(couse_name: e)
        r.couse_id = r.id
        r.save
      end
      couse_id = Couse.pluck(:couse_id)
      couse_id.each do |e|
        CouseParameter.create(
          couse_id: e
        )
          end
  
end
# 実行メソッド
couses()

# umaレコード
class Uma  < ApplicationRecord

  def get_uma(te)
    agent = Mechanize.new
    page = agent.get(te)

    elements = page.search('td.border_color a')
    
    elements.each do |element|
      uma = Uma.new
      uma.name = element.inner_text
      uma.code = element.get_attribute('href').to_s
      uma.code = uma.code[44...54].to_s
      p uma.name
      uma.save
    end
  end



  def umas_index_link
    agent = Mechanize.new
    is = (0..9).to_a
    is.each do |i|
      c = 0
      next_url = 0

        while true

            next_url = next_url + 1
          p "=============================================="
          p next_url
          p "=============================================="
            # get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c="+ i.to_s + "&page=" + next_url.to_s)
            # get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c="+ i.to_s + "&page=" + next_url.to_s)
            get_uma("https://umanity.jp/racedata/database_search_horse.php?mode=1&c="+ i.to_s + "&page=" + next_url.to_s)
        p "=============================================="
        p c
        p "=============================================="
        break unless next_url < 35
      end
    end
  end
end
  
# 実行メソッド
# u = Uma.new
# u.umas_index_link


# raceレコード
class Race  < ApplicationRecord
  def get_race(te)
    agent = Mechanize.new
    page = agent.get(te)

    elements_a = page.search('table.racedata_race_chart_table td a')
    
    elements_a.each do |element|
      if element.get_attribute('href').include?('//umanity.jp/racedata/race_21.php?code')
        race = Race.new
        race.code = element.get_attribute('href').to_s
        race.code = race.code[39..55].to_s
        race.name = element.inner_text
        p race.code
        p "ffff"
        unless Race.find_by(code: race.code)
        p "tttt"
        p race.code
          race.save
        end
      end
    end
  end

  def uma_race_link
    agent = Mechanize.new

    codes = Uma.pluck(:code)


    codes.each do |code|
      get_race("https://umanity.jp/racedata/db/horse_top.php?code=" + code.to_s)
    end


  end

end
# r = Race.new
# r.uma_race_link
