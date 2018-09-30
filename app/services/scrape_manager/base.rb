module ScrapeManager::Base
  extend self

  def yard_sales(city: 'Durham', date: Date.today)
    # ScrapeManager::YardsaleSearch.yard_sales(city: city, date: date)
    ScrapeManager::YardSalesNet.yard_sales(city: city, date: date)
    # TODO: Add other sites
    # Craigslist.yard_sales(city: city, date: date)
  end

  def test_yard_sales(city: 'Durham', date: Date.today)
    YardsaleSearch.test_yard_sales(city: city, date: date)
    # TODO: Add ScrapeManager::YardSalesNet
  end
end