class V1::Dashboards::DashboardController < V1::CacheController
  #before_filter authorize_user!

  api :GET, "/dashboard/menu", "List dashboad role specific menu"
  meta "## No params needed"
  def menu
    load_menu
    render_menu
  end

  protected
  def load_menu
    key = "dashboard_#{current_user.xrole.name}"
    menu = cache_with key, expires_in: 1.day do
      Menu.find_by(name: key).children
    end
    @menu = ActiveModel::ArraySerializer.new(menu, each_serializer: MenuSerializer)
  end

  def authorized_user!
    authorize! :read, Menu
  end

  def render_menu
    render status: 200, json: {
      menu: @menu
    }
  end
end
