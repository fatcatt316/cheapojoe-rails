module ScrapeManager::Base
  extend self

  def yard_sales(city: 'Asheville', date: Date.today)
    [
      ScrapeManager::YardsaleSearch.yard_sales(city: city, date: date),
      ScrapeManager::YardSalesNet.yard_sales(city: city, date: date)
    ].flatten
  end

  def test_yard_sales(city: 'Asheville', date: Date.today)
    YardsaleSearch.test_yard_sales(city: city, date: date)
    # TODO: Add ScrapeManager::YardSalesNet
  end
end