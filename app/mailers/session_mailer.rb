class SessionMailer < ActionMailer::Base
  default from: ENV["sender_email"]

  def test
    @url  = "http://#{ENV['host_front']}/login"
    mail(to: ENV["notify_email"], subject: "Bebras Taiwan # Test mailer")
  end

  def reset(user)
    @user = user
    @url  = "http://#{ENV['host_front']}/login"
    mail(to: @user.email, subject: "Bebras Taiwan # Password Reset link")
  end

  def create(user)
    @user = user
    @home = "http://#{ENV['host_front']}"
    sub = "[Bebras 系統通知] 已確認教師身份"
    mail(to: user.email, subject: sub)
  end
end
