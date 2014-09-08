module V1::FrontendHelper
  def msg status
    key = status ? "success" : "fail"
    return { msg: {
      title: I18n.t(:title, scope: "#{controller_name}.#{action_name}.#{key}"),
      body: I18n.t(:body, scope: "#{controller_name}.#{action_name}.#{key}")
    }}
  end

  def jmsg status, emsg={}
    scope = "#{controller_name}.#{action_name}.#{status}"
    bvar = { scope: scope }.merge(emsg)
    {
      title: I18n.t(:title, scope: scope),
      body: I18n.t(:body, bvar)
    }
  end
end
