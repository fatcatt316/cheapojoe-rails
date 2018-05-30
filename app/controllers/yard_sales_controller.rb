class YardSalesController < ApplicationController
  CITIES = %w(Asheville Durham) # TODO: Store this somewhar else

  def index
    @cities = CITIES
  end

  def create
    # TODO
  end

  private def yard_sale_params
    params.permit(:city, :date)
  end
end
