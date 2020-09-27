require 'mechanize'

class Uma < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}

  def self.umas_index_a_link
      agent = Mechanize.new

      texts = []

      next_url = ""

      while true
          current_page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=0&page=#{next_url}")
          next_page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=0&page=#{next_url + 1}")

          current_url = current_page.search('td b')
          texts << current_url
          next_url = current_url.text.to_i + 1
          break unless next_page
      end

      texts.each do |te|
        get_uma("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=0&page=" + te)
      end

    end

  def self.get_uma(te)
      Mechanize.new
      page = agent.get(te)

      def while
        elements = page.search('tr.white a')
        
        elements.each do |element|
          uma = Uma.new
          uma.name = element.inner_text
          uma.save
        end
      end

      def cream
            elements = page.search('tr.cream a')
            
            elements.each do |element|
              uma = Uma.new
              uma.name = element.inner_text
              uma.save
            end
        end
  end

end
