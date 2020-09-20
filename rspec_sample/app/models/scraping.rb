class Scraping < ApplicationRecord
  # require 'mechanize'

  # def self.scrape
  #   agent = Mechanize.new
  #   page = agent.get('https://moshicom.com/search/?s=3&keyword=&event_start_date=&event_end_date=&entry_status=yes&except_eventup=no&scale=0&disciplines%5B%5D=11&day_entry=no&measurement=no&user_id=0&search_type=0&recommend_event=true&recommend_course=true&recommend_facility=true&mode=1&l=40&o=0&m=1&keywords=&date_start=&date_end=&sort=2&disp_limit=20')

  #   elements = page.search('event.title')

  #   elements.each do |element|
  #     puts element.inner_text
  #   end
  # end

  def self.scrape
    require 'nokogiri'
require 'open-uri'

url = 'https://moshicom.com/search/?keywords=&date_start=&date_end=&disciplines%5B8%5D=11&scale=0&sort=2&disp_limit=20&mode=1'

charset = nil

html = open(url) do |f|
    charset = f.charset
    f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)
doc.xpath('//h3[@class="card-title"]').each do |node|
  p node.css('a').inner_text
end

  end

end
