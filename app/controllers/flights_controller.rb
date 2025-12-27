class FlightsController < ApplicationController
  def index
    @flight = Flight.new
    @available_dates = Flight.all.map { |flight| flight.date }.uniq.sort

    if params[:flight]
      flight_params = params[:flight]

      @flights = Flight.where(departure_airport_id: flight_params[:departure_airport_id]).where(arrival_airport_id: flight_params[:arrival_airport_id]).where(date: flight_params[:date])
    else
      @flights = Flight.order(:date)
    end
  end
end
