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

    @flight.assign_attributes(passenger_params)
    new_passengers = @flight.passengers.select(&:new_record?)

     if @flight.update(passenger_params)
      new_passengers.each do |passenger|
        PassengerMailer.with(passenger: passenger, flight: @flight).flight_booked_email.deliver_later
      end

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
