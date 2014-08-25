class PasswordMailer < ActionMailer::Base
  default from: "'No-Reply' <little_beaver@#{ENV['host_email']}>"

  def test
    @url  = "http://#{ENV['host_front']}/login"
    mail(to: ENV["notified_address"], subject: "Bebras Taiwan # Test mailer")
  end

  def reset(user)
    @user = user
    @url  = "http://#{ENV['host_front']}/login"
    mail(to: @user.email, subject: "Bebras Taiwan # Password Reset link")
  end
end
