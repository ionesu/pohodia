class ToursMailer < ApplicationMailer
  layout 'tours_mailer'

  def tour_created
    @tour = params[:tour]
    Administrator.pluck(:email).each do |email_to|
      mail(to: email_to, subject: I18n.t('tour_mail.new_tour'))
    end
  end

  def tour_moderation
    @tour = params[:tour]
    unless emails_to.blank?
      emails_to.each do |email_to|
        mail(to: email_to, subject: I18n.t('tour_mail.update_tour'))
      end
    end
  end

  def tour_review
    @tour_comment = params[:tour_comment]
    @tour = @tour_comment.tour
    emails_to.each do |email_to|
      mail(to: email_to, subject: I18n.t('tour_mail.add_review'))
    end
  end

  def tour_booking
    @tour = params[:tour]
    emails_to.each do |email_to|
      mail(to: email_to, subject: I18n.t('tour_mail.tour_booking'))
    end
  end

  private

  def emails_to
    if @tour.guide_company.present? && @tour.guide_company.email.present?
      [@tour.guide.email, @tour.guide_company.email]
    elsif @tour.guide.present? && @tour.guide&.email.present?
      [@tour.guide.email]
    else
      []
    end
  end
end