class Test
  require 'mechanize'
  require 'selenium-webdriver'
  def self.scrape
    #サイト1
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')

    driver = Selenium::WebDriver.for :chrome, options: options
    driver.navigate.to "https://moshicom.com/search/?keywords=&date_start=&date_end=&disciplines%5B8%5D=11&scale=0&sort=2&disp_limit=20&mode=1" 

    elements_list = driver.find_element(:css, '.contents-list') 
    elements = elements_list.find_elements(:css, '.card-main')
    elements.each do |element|
      post = Post.new
      post.date = element.find_element(:css, 'time').text
      post.locate = element.find_element(:css, '.icon-pin').text
      post.title = element.find_element(:css, '.card-title a').text
      post.person = element.find_element(:css, '.user a').text
      post.link = element.find_element(:css, '.card-title a').attribute('href')
      post.save
    end

    driver.quit
    #/サイト1

    #サイト2
    agent = Mechanize.new
    next_url = "https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=desc"
    while true
      current_page = agent.get( next_url)

      elements = current_page.search('.event_item article')

      elements.each do |element|
        element_person = element.at('.crew_info a')

        person_page_link = element_person.get_attribute('href')
        person_page = agent.get(person_page_link)
        person = person_page.at('.container .strong')
        person_name = person.inner_text

        post = Post.new
        post.date = element.at('.event_eyecatch .event_date span').inner_text
        post.locate = element.at('.event_info .event_location span').inner_text
        post.title = element.at('.event_info .event_title a').inner_text
        post.person = person_name
        post.link = element.at('.event_info .event_title a').get_attribute('href')
        post.save
      end

      next_link = current_page.at('.pager a[@rel="next"]')
      break unless next_link
      next_url = next_link.get_attribute('href')
    end
    #/サイト2

  end
end