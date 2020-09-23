set :environment, :development
set :output, {:error => 'log/error.log', :standard => 'log/cron.log'}

every 1.day, :at => '7:00 am' do
  runner "Test.scrape"
end

# bundle exec whenever --update-cron
# bundle exec whenever
# bundle exec whenever --clear-cron