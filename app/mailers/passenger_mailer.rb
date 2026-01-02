class PassengerMailer < ApplicationMailer
  default from: "hello@flightbooker.com"

  def flight_booked_email
    @passenger = params[:passenger]
    @flight = params[:flight]
    mail(to: @passenger.email, subject: "Flight booked successfuly!")
  end
end
