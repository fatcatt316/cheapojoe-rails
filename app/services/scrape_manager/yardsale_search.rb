require 'mechanize'
module ScrapeManager::YardsaleSearch
  extend self

  CITIES = %w(Asheville Durham)

  # TODO: Cache for awhile
  # Example of what's returned:
  # [
  #   {:city=>"Durham", :state=>"North Carolina", :street_address=>"414 N Hardee St", :description=>"Huge yard sale everything must go sandals tennis shoes house hold items children… Read More →"},
  #   {:city=>"Durham", :state=>"North Carolina", :street_address=>"1116 Alben St", :description=>"Swing by on Saturday as we have multiple families eager to clear out some… Read More →"},
  #   {:city=>"Durham", :state=>"North Carolina", :street_address=>"816 Northwood Hills Ave", :description=>"Gently used furniture, clothing, bikes, household decor and more!!! Moving and… Read More →"}
  # ]
  def yard_sales(city: 'Durham', date: Date.today)
    return [] unless city.in?(CITIES)

    # date = Date.new(2018, 6, 16)
    scraper = Mechanize.new
    scraper.get(search_url(city: city, date: date)) do |search_page|
      return yard_sales_details(search_page)
    end
  end

  def test_yard_sales(city: 'Durham', date: Date.today)
    [{:city=>"Durham", :state=>"North Carolina", :street_address=>"414 N Hardee St", :description=>"Huge yard sale everything must go sandals tennis shoes house hold items children… Read More →"}, {:city=>"Durham", :state=>"North Carolina", :street_address=>"1116 Alben St", :description=>"Swing by on Saturday as we have multiple families eager to clear out some… Read More →"}, {:city=>"Durham", :state=>"North Carolina", :street_address=>"816 Northwood Hills Ave", :description=>"Gently used furniture, clothing, bikes, household decor and more!!! Moving and… Read More →"}]
  end

  private def yard_sales_details(search_page)
    search_page.search('.sale-details').map do |yard_sale|
      yard_sale_details(yard_sale)
    end
  end

  private def search_url(city: 'Durham', date: Date.today)
    # https://www.yardsalesearch.com/garage-sales.html?r=5&zip=Durham%2C+North+Carolina&date=2018-06-08
    # TODO: More than just North Carolina
    "https://www.yardsalesearch.com/garage-sales.html?r=5&zip=#{city}%2C+North+Carolina&date=#{date}"
  end

  private def yard_sale_details(yard_sale)
    {
      city: yard_sale.at('[itemprop="addressLocality"]')&.text,
      state: 'North Carolina',# TODO: Other states
      street_address: yard_sale.at('[itemprop="streetAddress"]').text,
      description: yard_sale.at('[itemprop="description"]')&.text
    }
  end
end