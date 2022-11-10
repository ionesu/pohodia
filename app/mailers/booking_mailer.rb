class BookingMailer < ApplicationMailer
	
	layout 'booking_mailer'
	#default from: 'booking@pohodia.com'
    
  def booking_created 
  	@booking = params[:booking]
		if @booking.customer_name.blank?
			email_with_name = %("#{@booking.customer_email}" <#{@booking.customer_email}>)
		else
			email_with_name = %("#{@booking.customer_name}" <#{@booking.customer_email}>)
		end
  	mail(to: email_with_name, subject: I18n.t('site.bookings.email.created_subject'))  	
  end
  
  
  def booking_notification
  	@booking = params[:booking]
  	
  	email_to = @booking.tour.try(:guide).try(:contact_email)  	
  	email_to ||= @booking.tour.try(:guide).try(:email)  	
  	mail(to: email_to, subject: I18n.t('site.bookings.email.notification_subject')) unless email_to.blank?
  	
  	email_to ||= @booking.tour.try(:guide_company).try(:email)
  	mail(to: email_to, subject: I18n.t('site.bookings.email.notification_subject')) unless email_to.blank?
  end
  
  
  def booking_changed
  	@booking = params[:booking]
  	unless @booking.customer_name.blank?
  		email_with_name = %("#{@booking.customer_name}" <#{@booking.customer_email}>)
  	else
  		email_with_name = %("#{@booking.customer_email}" <#{@booking.customer_email}>)
  	end
  	mail(to: email_with_name, subject: I18n.t('site.bookings.email.changed_subject'))
  end 
  
end
