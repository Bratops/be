class ContestMailer < ActionMailer::Base
  default from: ENV["sender_email"]

  def ans_fail(user, opt, emsg)
    @user = user
    @req = opt
    @emsg = emsg
    mail(
      to: ENV["notify_email"],
      subject: "Bebras # Contest Error")
  end
end
