module ScrapeManager
  extend self

  def yard_sales(city: 'Durham', date: Date.today)
    YardsaleSearch.yard_sales(city: city, date: date)
    # TODO: Add other sites
  end

  def test_yard_sales(city: 'Durham', date: Date.today)
    YardsaleSearch.test_yard_sales(city: city, date: date)
  end
end