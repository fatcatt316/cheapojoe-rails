class YardSalesController < ApplicationController
  CITIES = %w(Asheville Durham) # TODO: Store this somewhar else

  def index
    @cities = CITIES
  end

  def create
    # TODO: Get Date and City from passed in params
    # Figure out what scrapers to use based on City
    # USE THIS FOR THE REAL ONE
    render json: ScrapeManager::Base.yard_sales(city: yard_sale_params[:city], date: yard_sale_params[:date])
    # render json: ScrapeManager.test_yard_sales(city: yard_sale_params[:city], date: yard_sale_params[:date])
  end

  private def yard_sale_params
    params.permit(:city, :date)
  end
end
