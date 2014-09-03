class V1::Dashboards::DashboardController < V1::BaseController
  before_filter authorize_user!

  def menu
    render status: 200, json: {
      user: user_info_json
      #menu: MenuSerializer.new(menu)
    }
  end

  def submenu
  end

  protected
  def authorized_user!
    authorize! :read, Menu
  end
end
