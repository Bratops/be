module V1::FrontendHelper
  def msg status
    key = status ? "success" : "fail"
    return { msg: {
      title: I18n.t(:title, scope: "#{controller_name}.#{action_name}.#{key}"),
      body: I18n.t(:body, scope: "#{controller_name}.#{action_name}.#{key}")
    }}
  end

  def jmsg status
    {
      title: I18n.t(:title, scope: "#{controller_name}.#{action_name}.#{status}"),
      body: I18n.t(:body, scope: "#{controller_name}.#{action_name}.#{status}")
    }
  end
end
