class V1::Dashboards::Admin::MenuController < V1::BaseController
  include V1::MessageHelper
  before_filter :authorize_user!

  api "POST", "/dashboard/admin/menu", "update menu items"
  def update
    root = Menu.find_by(name: "dashboard_#{role_param}")
    suc = root.nil? ? false : true
    emsg = ""

    menu_param.each do |m|
      break unless suc
      next if m[:name] && m[:name].include?("dashboard_")
      if m[:id] > 0
        rc = root.children.find(m[:id])
        suc = m[:destroy] ? rc.destroy : rc.update(m.slice! :id, :destroy)
      else
        suc = root.children.create(m.slice! :id)
      end
    end

    clear_cache role_param if suc

    status = suc ? "success" : "error"
    render status: 200, json: {
      msg: tmsg(status, current_user.xrole.name, {field: emsg.to_s})
    }
  end

  private
  def authorize_user!
    authorize! :manage, Menu
  end

  def menu_param
    menu_attr = [:id, :pos, :name, :icon, :link,
                 :tube, :info_link, :desc, :destroy]
    params.permit(menu: menu_attr).require(:menu)
  end

  def role_param
    params.require(:role)
  end

  def clear_cache role
    rk = "dashboard.menu.dashboard_#{role}"
    Rails.cache.delete(rk)
  end
end
