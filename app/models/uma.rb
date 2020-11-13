require 'mechanize'

class Uma < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}


  def self.get_uma_white(te)
    agent = Mechanize.new
    page = agent.get(te)

    elements = page.search('tr.white a')
    
    elements.each do |element|
      uma = Uma.new
      uma.name = element.inner_text
      uma.code = element.get_attribute('href').to_s
      uma.code = uma.code[44...54].to_s
      uma.save
    end
  end

  def self.get_uma_cream(te)
    agent = Mechanize.new
    page = agent.get(te)

    elements = page.search('tr.cream a')
    
    elements.each do |element|
      uma = Uma.new
      uma.name = element.inner_text
      uma.code = element.get_attribute('href').to_s
      uma.code = uma.code[44...54].to_s

      uma.save
    end
  end



  def self.umas_index_link
    agent = Mechanize.new
    is = (0..8).to_a
    is.each do |i|
      c = 0
      next_url = 0

        while true

            next_url = next_url + 1
          p "=============================================="
          p next_url
          p "=============================================="
            get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c="+ i.to_s + "&page=" + next_url.to_s)
            get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c="+ i.to_s + "&page=" + next_url.to_s)
        p "=============================================="
        p c
        p "=============================================="
        break unless next_url < 35
      end
    end

  end
  
  # def self.umas_index_ka_link
  #   agent = Mechanize.new

  #   c = 0
  #   next_url = 0

  #     while true

  #         next_url = next_url + 1
  #       p "=============================================="
  #       p next_url
  #       p "=============================================="
  #         get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=1&page=" + next_url.to_s)
  #         get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=1&page=" + next_url.to_s)
  #     p "=============================================="
  #     p c
  #     p "=============================================="
  #     break unless next_url < 35
  #   end


  # end

  # def self.umas_index_sa_link
  #   agent = Mechanize.new

  #   c = 0
  #   next_url = 0

  #     while true

  #         next_url = next_url + 1
  #       p "=============================================="
  #       p next_url
  #       p "=============================================="
  #         get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=2&page=" + next_url.to_s)
  #         get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=2&page=" + next_url.to_s)
  #     p "=============================================="
  #     p c
  #     p "=============================================="
  #     break unless next_url < 35
  #   end


  # end

  # def self.umas_index_ta_link
  #   agent = Mechanize.new

  #   c = 0
  #   next_url = 0

  #     while true

  #         next_url = next_url + 1
  #       p "=============================================="
  #       p next_url
  #       p "=============================================="
  #         get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=3&page=" + next_url.to_s)
  #         get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=3&page=" + next_url.to_s)
  #     p "=============================================="
  #     p c
  #     p "=============================================="
  #     break unless next_url < 35
  #   end


  # end

  # def self.umas_index_na_link
  #   agent = Mechanize.new

  #   c = 0
  #   next_url = 0

  #     while true

  #         next_url = next_url + 1
  #       p "=============================================="
  #       p next_url
  #       p "=============================================="
  #         get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=4&page=" + next_url.to_s)
  #         get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=4&page=" + next_url.to_s)
  #     p "=============================================="
  #     p c
  #     p "=============================================="
  #     break unless next_url < 35
  #   end


  # end

  # def self.umas_index_ha_link
  #   agent = Mechanize.new

  #   c = 0
  #   next_url = 0

  #     while true

  #         next_url = next_url + 1
  #       p "=============================================="
  #       p next_url
  #       p "=============================================="
  #         get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=5&page=" + next_url.to_s)
  #         get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=5&page=" + next_url.to_s)
  #     p "=============================================="
  #     p c
  #     p "=============================================="
  #     break unless next_url < 35
  #   end


  # end

  # def self.umas_index_ma_link
  #   agent = Mechanize.new

  #   c = 0
  #   next_url = 0

  #     while true

  #         next_url = next_url + 1
  #       p "=============================================="
  #       p next_url
  #       p "=============================================="
  #         get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=6&page=" + next_url.to_s)
  #         get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=6&page=" + next_url.to_s)
  #     p "=============================================="
  #     p c
  #     p "=============================================="
  #     break unless next_url < 35
  #   end


  # end

  # def self.umas_index_ya_link
  #   agent = Mechanize.new

  #   c = 0
  #   next_url = 0

  #     while true

  #         next_url = next_url + 1
  #       p "=============================================="
  #       p next_url
  #       p "=============================================="
  #         get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=7&page=" + next_url.to_s)
  #         get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=7&page=" + next_url.to_s)
  #     p "=============================================="
  #     p c
  #     p "=============================================="
  #     break unless next_url < 35
  #   end


  # end

  # def self.umas_index_ra_link
  #   agent = Mechanize.new

  #   next_url = 0

  #     while true

  #         next_url = next_url + 1
  #       p "=============================================="
  #       p next_url
  #       p "=============================================="
  #         get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=8&page=" + next_url.to_s)
  #         get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=8&page=" + next_url.to_s)
  #     break unless next_url < 35
  #   end


  # end

  # def self.umas_index_wa_link
  #   agent = Mechanize.new

  #   c = 0
  #   next_url = 0

  #     while true

  #         next_url = next_url + 1
  #       p "=============================================="
  #       p next_url
  #       p "=============================================="
  #         get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=9&page=" + next_url.to_s)
  #         get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=9&page=" + next_url.to_s)
  #     p "=============================================="
  #     p c
  #     p "=============================================="
  #     break unless next_url < 35
  #   end


  # end

  # def self.search(search)
  #   return Uma.all unless search
  #   Uma.where(['name LIKE ?', "%#{search}%"])
  # end

end
