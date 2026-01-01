class BookingsController < ApplicationController
  def new
    @number_of_passengers = params[:number_of_passengers].to_i

    @booking = Booking.new

    @flight = Flight.find(params[:flight_id])

    @dummy_flight = Flight.new
    @number_of_passengers.times { @dummy_flight.passengers.build }
  end

  def create
    @flight = Flight.find(params[:flight][:flight_id])
     if @flight.update(passenger_params)
      flash[:success] = "You have successfully booked your tickets."
      redirect_to :root
     else
      render :new, status: :unprocessable_entity
     end
  end

  def show
  end

  private
  def passenger_params
    params.expect(flight: [ passengers_attributes: [ [ :name, :email ] ] ])
  end
end
