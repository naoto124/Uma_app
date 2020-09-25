class Uma < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  require 'mechanize'

  def self.umas_index
    agent = Mechanize.new
    # page_a =('1'..'24').to_a
    # page_ka =('1'..'21').to_a
    # page_sa =('1'..'26').to_a
    # page_ta =('1'..'18').to_a
    # page_na =('1'..'6').to_a
    # page_ha =('1'..'19').to_a
    # page_ma =('1'..'16').to_a
    # page_ya =('1'..'3').to_a
    # page_ra =('1'..'16').to_a
    # page_wa =('1'..'2').to_a



    def pages


      kana = [a,ka,sa,ta,na,ha,ma,ya,ra,wa]

      a.each do |i|
        if page
          page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=0&page=#{i}")
        else
          break
        end
      end
      
      ka.each do |i|
        if page
          page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=1&page=#{i}")
        else
          break
        end
      end

      sa.each do |i|
        if page
          page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=2&page=#{i}")
        else
          break
        end
      end

      ta.each do |i|
        if page
          page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=3&page=#{i}")
        else
          break
        end
      end

      na.each do |i|
        if page
          page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=4&page=#{i}")
        else
          break
        end
      end

      ha.each do |i|
        if page
          page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=5&page=#{i}")
        else
          break
        end
      end

      ma.each do |i|
        if page
          page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=6&page=#{i}")
        else
          break
        end
      end

      ya.each do |i|
        if page
          page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=7&page=#{i}")
        else
          break
        end
      end

      ra.each do |i|
        if page
          page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=8&page=#{i}")
        else
          break
        end
      end

      wa.each do {|i| i = 1++}
        if page
          page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=9&page=#{i}")
        else
          break
        end
      end

    end


    pages.each do |page|
        elements = page.search('tr.white a')
        
        elements.each do |element|
          uma = Uma.new
          uma.name = element.inner_text
          uma.save
      end
    end
  end

  # def self.umas_index_c
  #   agent = Mechanize.new
  #   page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=0&page=1")
  #   elements = page.search('tr.cream a')
  #   elements.each do |element|
  #     uma = Uma.new
  #     uma.name = element.inner_text
  #     uma.save
  #   end
  # end
end
