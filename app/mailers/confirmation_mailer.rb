require "action_mailer"

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 465,
  :domain               => '@gmail.com',
  :user_name            => 'develror',
  :password             => '12345^&*()',
  :authentication       => "plain",
  :ssl                  => true,
  :tls                  => true,
  :enable_starttls_auto => true
}


class ConfirmationMailer < ActionMailer::Base
  def confirm_email(target_email, url_host, activation_token)
    @activation_token = activation_token
    @url_host = url_host
    mail(:to => target_email,
      :from => "develror@gmail.com",
      :subject => "[Training - Rails 4]") do |format|
      format.html { render 'confirm_email'}
    end
  end
end

#class ConfirmationMailer < ApplicationMailer
  #def confirmation_email(target_email,activation_token)
    #@activation_token = activation_token
    #mail(:to => target_email, :from => "mirzalazuardi@gmail.com", :subject => "[Training - Rails]") do |format|
           #format.html { render 'confirm_email' }
         #end
  #end
#end
