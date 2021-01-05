require 'mechanize'

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

  def self.get_uma(te)
    agent = Mechanize.new
    page = agent.get(te)

    elements = page.search('td.border_color a')
    
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
  

u = Uma.new
u.umas_index_link