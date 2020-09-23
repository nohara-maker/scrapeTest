require 'rails_helper'
require 'mechanize'
require 'selenium-webdriver'

RSpec.describe Test, type: :model do
    describe "テスト1" do
      it "Seleniumを使用しChromeにヘッドレスでサイトに接続する" do
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--headless')
      options.add_argument('--disable-gpu')

      driver = Selenium::WebDriver.for :chrome, options: options
      driver.navigate.to "https://www.google.com/" 
      expect(driver.title).to eq "Google"
      end
  end
end

RSpec.describe Test, type: :model do
  describe "テスト2" do
    it "複数ページの取得" do
      agent = Mechanize.new
      next_url = "https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=desc"
      i = 1
      while true
        current_page = agent.get( next_url)
        next_link = current_page.at('.pager a[@rel="next"]')
        break unless next_link
        next_url = next_link.get_attribute('href')
        i = i + 1
      end
      expect(i).to eq 6 #ページ数
    end
  end
end

RSpec.describe Test, type: :model do
  describe "テスト3" do
    it "イベントの募集ごとに主催者のページに接続しフルネームを取得する" do
      agent = Mechanize.new
      url = "https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=desc"
      current_page = agent.get(url)
      element = current_page.at('.event_item article')
      element_person = element.at('.crew_info a')
      person_page_link = element_person.get_attribute('href')
      person_page = agent.get(person_page_link)
      person = person_page.at('.container .strong')
      person_name = person.inner_text
      expect(person.inner_text).to eq "福田川クリーンクラブ" #ページで一番上の募集の主催者のフルネーム
    end
  end
end