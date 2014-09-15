class V1::Dashboards::Admin::MenuController < V1::BaseController
  include V1::MessageHelper
  before_filter :authorize_user!

  api "POST", "/dashboard/admin/menu", "update menu items"
  def update
    root = Menu.find_by(name: "dashboard_#{role_param}")
    suc = (root.nil? || root.children.size == 0) ? false : true
    emsg = ""
    menu_param.each do |m|
      break unless suc
      next if m[:name] && m[:name].include?("dashboard_")
      if m[:id] > 0
        rc = root.children.find(m[:id])
        suc = suc && rc.update(m.slice! :id, :destroy)
        if m[:destroy]
          suc = suc && rc.delete
        end
      else
        suc = suc && root.children.create(m.slice! :id)
      end
      unless suc
        rk = rc.errors.keys()
        emsg = "#{rk} #{rk.map{|k| rc[k]}}"
        break
      end
    end
    if suc
      clear_cache role_param
    end
    status = suc ? "success" : "error"
    render status: 200, json: {
      status: status,
      msg: jmsg(status, {field: emsg.to_s})
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
