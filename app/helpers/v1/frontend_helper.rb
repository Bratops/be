module V1::FrontendHelper
  def msg status
    key = status ? "success" : "fail"
    return { msg: {
      title: I18n.t(:title, scope: "#{controller_name}.#{action_name}.#{key}"),
      body: I18n.t(:body, scope: "#{controller_name}.#{action_name}.#{key}")
    }}
  end

  def ad_msg
    res = "resource"#{controller_name}.#{action_name}"
    {
      status: "error",
      msg: {
        title: I18n.t(:title, scope: "exception.access_deny",
                     resource: res),
        body: I18n.t(:body, scope: "exception.access_deny",
                    resource: res)
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

  def cmsg status, msgv={}
    role = current_user.xrole.name
    scope = "#{role}.#{controller_name}.#{action_name}.#{status}"
    msg_base status, scope, msgv
  end

  def tmsg status, role="", msgv={}
    role = role.blank? ? "" : "#{role}."
    scope = "#{role}#{controller_name}.#{action_name}.#{status}"
    msg_base status, scope, msgv
  end

  private
  def msg_base state, scope, var
    bvar = { scope: scope }.merge(var)
    {
      status: state,
      title: I18n.t(:title, bvar),
      body: I18n.t(:body, bvar)
    }
  end
end
