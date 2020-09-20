class Test
  require 'mechanize'
  def self.scrape
    agent = Mechanize.new
    links = []
    next_url = "https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=desc"
    while true
      current_page = agent.get( next_url)

      elements = current_page.search('.event_item article')

      elements.each do |element|
        element_date = element.at('.event_eyecatch .event_date span')
        element_time = element.at('.event_info .event_time span')
        element_locate = element.at('.event_info .event_location span')
        element_title = element.at('.event_info .event_title a')
        element_person = element.at('.crew_info a')
        # person = element_person.at('.crew_name') 
        # person_name = person.inner_text 
        person_page_link = element_person.get_attribute('href')
        person_page = agent.get(person_page_link)
        person = person_page.at('.container .strong')
        person_name = person.inner_text
        fish = Fish.new
        fish.date = element_date.inner_text
        fish.time = element_time.inner_text
        fish.locate = element_locate.inner_text
        fish.title = element_title.inner_text
        fish.person = person_name
        fish.link = element_title.get_attribute('href')
        fish.save
        # if User.find_by(name: person_name)
        #   hoge = Hoge.new
        #   hoge.date = element_date.inner_text
        #   hoge.time = element_time.inner_text
        #   hoge.locate = element_locate.inner_text
        #   hoge.title = element_title.inner_text
        #   hoge.person = person_name
        #   hoge.link = element_title.get_attribute('href')
        #   hoge.save
        # end
      end

      next_link = current_page.at('.pager a[@rel="next"]')
      break unless next_link
      next_url = next_link.get_attribute('href')
    end
  end
end