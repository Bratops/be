class V1::PasswordController < V1::BaseController
  include Devise::Controllers::Helpers
  skip_before_filter :authenticate_user_from_token!, :only => [:mail_test]

  def mail_test
    mail = PasswordMailer.test
    mail.deliver
    render json: { console: "ok"}, status: 200
  end

  def request_reset
  end

  def reset
  end

  def change
  end
end
