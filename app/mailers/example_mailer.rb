class ExampleMailer < ApplicationMailer
	default from: "myconference123@gmail.com"

  def booking_email(user, booking)
    @user = user
    @booking = booking
    mail(to: @user.email, subject: 'Booking Confirmed.')
  end	

  def pending_email(user, booking)
    @user = user
    @booking = booking    
    mail(to: @user.email, subject: 'Pending Confirmed.')
  end	

  def cancel_email(user, booking)
    @user = user
    @booking = booking    
    mail(to: @user.email, subject: 'Cancel Confirmed.')
  end	
end
