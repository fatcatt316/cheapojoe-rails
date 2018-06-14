module ScrapeManager
  extend self

  def yard_sales(city: 'Durham', date: Date.today)
    YardsaleSearch.yard_sales
    # TODO: Add other sites
  end
end