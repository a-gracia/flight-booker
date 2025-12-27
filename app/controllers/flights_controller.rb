class FlightsController < ApplicationController
  def index
    @flight = Flight.new
  end
end
