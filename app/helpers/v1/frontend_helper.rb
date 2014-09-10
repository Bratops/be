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

  def tmsg status, role="", msgv={}
    role = role.blank? ? "" : "#{role}."
    scope = "#{role}#{controller_name}.#{action_name}.#{status}"
    bvar = { scope: scope }.merge(msgv)
    {
      status: status,
      title: I18n.t(:title, bvar),
      body: I18n.t(:body, bvar)
    }
  end
end
