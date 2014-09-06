class V1::Dashboards::DashboardController < V1::CacheController
  #before_filter authorize_user!

  api :GET, "/dashboard/menu", "List dashboad role specific menu"
  param :edit, String, "request menu items for edit by given role name"
  meta "## if no `:edit` params passed, just return role specific menu items"
  def menu
    if params[:edit] && (authorize! :edit, Menu)
      load_full_menu
    else
      load_menu
    end
    render_menu
  end

  protected
  def load_full_menu
    return if !current_user.has_role?(params[:edit])
    key = "dashboard_#{params[:edit]}"
    menu = Menu.find_by(name: key).children
    #Rails.cache.delete(sk)
    @menu = ActiveModel::ArraySerializer.new(menu, each_serializer: MenuSerializer)
  end

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
