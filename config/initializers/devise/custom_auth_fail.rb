class CustomAuthFailure < Devise::FailureApp
  def respond
    self.status = 401
    self.content_type = "json"
    self.response_body = {
      status: "error",
      msg: {
        title: I18n.t(:title, scope: "devise.fail_app"),
        body: I18n.t(:body, scope: "devise.fail_app")
      }
    }.to_json
  end
end
