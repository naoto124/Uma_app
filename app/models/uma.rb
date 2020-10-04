require 'mechanize'

class Uma < ApplicationRecord
  validates :name, {presence: true, uniqueness: true}
  def self.umas_index_a_link
    agent = Mechanize.new

    # texts = []

    next_url = 0

    while true
        # current_page = agent.get("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=0&page=#{next_url}")

      # next_pageをどう撮るか　breakのさせ方

        # current_url = current_page.search('td b')
        next_url = next_url + 1
        # texts << current_url
p "=============================================="
p next_url
p "=============================================="
        # next_url = current_url.text.to_i + 1
        get_uma_white("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=0&page=" + next_url.to_s)
        get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=0&page=" + next_url.to_s)

        break unless next_url < 35
    end

    # texts.each do |te|
    # end

    # texts.each do |te|
      # get_uma_cream("https://umanity.jp/racedata/database_search_horse.php?mode=1&c=0&page=" + te)
    # end

  end

  def self.get_uma_white(te)
    agent = Mechanize.new
    page = agent.get(te)

    elements = page.search('tr.white a')
    
    elements.each do |element|
      uma = Uma.new
      uma.name = element.inner_text
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
      uma.save
    end
  end

end
