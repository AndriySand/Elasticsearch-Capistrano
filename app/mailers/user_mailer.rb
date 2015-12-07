class UserMailer < ApplicationMailer
  def welcome_email(email, number_of_records)
    @number_of_records = number_of_records
    mail(to: email, subject: 'Records from CSV file was imported')
  end
end
