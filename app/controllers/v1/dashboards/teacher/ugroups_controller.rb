class V1::Dashboards::Teacher::UgroupsController < V1::BaseController
  include V1::FrontendHelper

  def index
    ug = Ugroup.with_role(:teacher, current_user)
    us = ActiveModel::ArraySerializer.new(ug, each_serializer: UgroupSerializer)
    render json: us
  end

  def create
    authorize! :create, Ugroup
    suc = false
    ugs = Ugroup.with_role(:teacher, current_user)
    ug = ugs.find_by(name: ugroup_params["name"])
    data = nil
    if ug
      sts = "warning"
      msgv = { group_name: ugroup_params["name"] }
    else
      rt = create_ugroup
      data = rt[:data]
      sts = rt[:status] ? "success" : "error"
      msgv = rt[:status] ? { group_name: ugroup_params["name"] } : { error: ug.errors.messages }
    end
    render json: {
      msg: tmsg(sts, current_user.xrole.name, msgv),
      data: UgroupSerializer.new(data)
    }
  end

  def show
  end

  def update
    ug = Ugroup.find_by_id(params[:id])
    authorize! :update, ug
    data = nil
    unless ug
      sts = "error"
      msgv = {error: ""}
    else
      suc = ug.update(ugroup_params)
      sts = suc ? "success" : "error"
      msgv = suc ? { group_name: ugroup_params["name"] } : { error: ug.errors.messages }
      data = suc ? ug : nil
    end
    render json: {
      msg: tmsg(sts, current_user.xrole.name, msgv),
      data: UgroupSerializer.new(data)
    }
  end

  def destroy
    ug = Ugroup.find_by_id(params[:id])
    authorize! :destroy, ug
    ugn = ug.name
    suc = ug.delete
    sts = suc ? "success" : "error"
    msgv = suc ? { group_name: ugn } : {}
    render json: {
      msg: tmsg(sts, current_user.xrole.name, msgv),
    }
  end

  private
  def ugroup_params
    params.require(:grp).permit(
      :name, :klass, :exdate, :extime, :grade, :note)
  end

  def create_ugroup
    suc = false
    ug = Ugroup.create(ugroup_params)
    if ug
      ug.school = current_user.current_group.school
      if ug.save
        current_user.add_role :teacher, ug
        suc = true
      end
    end
    { status: suc, data: ug }
  end
end
