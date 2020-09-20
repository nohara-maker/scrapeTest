class User < ApplicationRecord
  require 'selenium-webdriver'
  
  def self.scrape
    require 'selenium-webdriver'

driver = Selenium::WebDriver.for :chrome #使用するブラウザを選択
driver.navigate.to "http://www.google.com" #URL指定
puts driver.title #ページタイトルを出力

element = driver.find_element(:name, 'description') #セレクタ指定
puts element.attribute('content') #コンソールに出力

driver.quit
  end


  # def full_name
  #   last_name + " " + first_name
  # end
end
