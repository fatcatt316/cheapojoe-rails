require 'mechanize'
module ScrapeManager::YardSalesNet
  extend self

  CITIES = %w(Asheville Durham)
  META_CITY_REGEX = /.*\s[AP]M\sin\s(?<city>.*),/

  # TODO: Cache for awhile
  # Example of what's returned:
  # [
  #   {:city=>"Durham", :state=>"North Carolina", :street_address=>"414 N Hardee St", :description=>"Huge yard sale everything must go sandals tennis shoes house hold items children… Read More →"},
  #   {:city=>"Durham", :state=>"North Carolina", :street_address=>"1116 Alben St", :description=>"Swing by on Saturday as we have multiple families eager to clear out some… Read More →"},
  #   {:city=>"Durham", :state=>"North Carolina", :street_address=>"816 Northwood Hills Ave", :description=>"Gently used furniture, clothing, bikes, household decor and more!!! Moving and… Read More →"}
  # ]
  def yard_sales(city: 'Asheville', date: Date.today)
    return [] unless city.in?(CITIES)

    # date = Date.new(2018, 6, 16)
    scraper = Mechanize.new
    scraper.get(search_url(city: city, date: date)) do |search_page|
      return yard_sales_details(search_page)
    end
  end

  def test_yard_sales(city: 'Asheville', date: Date.today)
    [{:city=>"Weaverville", :state=>"North Carolina", :street_address=>"72 Amber Knolls Court", :zip_code=>"28787", :description=>"We have antiques, furniture, smalls, glass, Tv , large love seat from havertys, cozy chair, beautiful rug, call to arrange pick up #828-284-3564… → Read More"}, {:city=>"Swannanoa", :state=>"North Carolina", :street_address=>" Samson Way", :zip_code=>"28778", :description=>"Swannanoa’s popular twice-annual community yard sale will take place on Saturday, October 6, from 8 a.m. - 1 p.m., in the Swannanoa Ingles parking lot, 2299 U.S. Highway 70. The sale attracts dozens of sellers and hundreds of shoppers - there’s something for everyone! Seller spaces (approx. 10’ x 15'; bring your own tables) are $10 each. To reserve a… → Read More"}, {:city=>"Arden", :state=>"North Carolina", :street_address=>"4 Pond Street", :zip_code=>"28704", :description=>"SONshine Crafters Annual Craft Show\nSaturday October 27, 2018  9AM to 3PM\nSkyland First Baptist Church\n2115 Hendersonville Rd\nArden, NC 28704… → Read More"}]
  end

  private def search_url(city: 'Asheville', date: Date.today)
    # https://yardsales.net/asheville-nc/
    # TODO: More than just North Carolina
    # TODO: date
    "https://yardsales.net/#{city.downcase}-nc/"
  end

  private def yard_sales_details(search_page)
    search_page.search('[data-id]').map do |yard_sale|
      yard_sale_details(yard_sale)
    end.compact
  end

  private def yard_sale_details(yard_sale)
    # e.g., yard_sale['data-coords'] "35.34162090,-82.41192490"
    result = Geocoder.search(yard_sale['data-coords'].split(',')).first
    return unless result

    {
      city: city_from_meta(yard_sale.at('.meta')&.text) || result.city,
      state: result.state,
      street_address: [result.house_number, result.street].compact.join(' '),
      zip_code: result.postal_code,
      description: yard_sale.at('[itemprop="description"]')&.text,
      url: url(yard_sale),
      source: 'yardsales.net'
    }
  end

  private def url(yard_sale)
    url = yard_sale.search('a').find{ |link| link['href'].starts_with?("/s/") }.try(:[], 'href')
    File.join('https://yardsales.net', url) if url
  end

  # e.g., "Posted on Sat, Sep 29, 2018 at 06:29 AM in Hendersonville, NC"
  private def city_from_meta(metatext)
    return unless metatext

    metatext.match(META_CITY_REGEX).try(:[], :city)
  end

end
