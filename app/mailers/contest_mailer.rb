class ContestMailer < ActionMailer::Base
  default from: ENV["sender_email"]

  def ans_fail(user, params, emsg)
    @user = user
    @req = params
    @emsg = emsg
    mail(to: ENV["notify_email"], subject: "Bebras # Contest Error")
  end
end
