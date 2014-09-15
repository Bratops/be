class V1::Dashboards::Teacher::UgroupsController < V1::BaseController
  include V1::MessageHelper
  before_filter :auth, except: [:index, :create]

  def index
    ugs = Ugroup.with_role(:teacher, current_user)
    us = ActiveModel::ArraySerializer.new(ugs, each_serializer: UgroupSerializer)
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

  def update
    data = nil
    unless @ug
      sts = "error"
      msgv = {error: ""}
    else
      suc = @ug.update(ugroup_params)
      sts = suc ? "success" : "error"
      msgv = suc ? { group_name: ugroup_params["name"] } : { error: @ug.errors.messages }
      data = suc ? @ug : nil
    end
    render json: {
      msg: tmsg(sts, current_user.xrole.name, msgv),
      data: UgroupSerializer.new(data)
    }
  end

  def destroy
    ugn = @ug.name
    suc = @ug.delete
    sts = suc ? "success" : "error"
    msgv = suc ? { group_name: ugn } : {}
    render json: {
      msg: tmsg(sts, current_user.xrole.name, msgv),
    }
  end

  def enrolls
    ens = @ug.enrollments
    ens = ActiveModel::ArraySerializer.new(ens, each_serializer: EnrollmentSerializer)
    render json: ens
  end

  def enroll
    ero = {}
    eid = nil
    sts = no_res @ug do
      en = @ug.update_enrollment user_params
      if en.errors.blank?
        sts = (en.created_at == en.updated_at) ? :success : :repeated
        eid = en.id
      else
        sts = :error
        ero = en.errors.keys.inject({}){|h, k| h[k] = true; h}
      end
      sts
    end
    render json: {
      user: {
        id: eid,
        status:{
          name: I18n.t(sts, scope: "teacher.ugroups.enroll.status"),
          value: sts == :success ? "added" : "error"
        }, error: ero
      } }
  end

  def del_enrolls
    ens = @ug.enrollments.where(status: "added")
    ens.delete(params[:ids])
    ens.reload
    render json: {
      msg: tmsg("success", current_user.xrole.name),
      keep: ens.pluck(:id)
    }
  end

  private

  def no_res res
    unless res
      return :not_found
    else
      return yield
    end
  end

  def user_params
    params.require(:user).permit(:id, :suid, :name, :gender, :seat)
  end

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

  def auth
    @ug = Ugroup.find_by_id(params[:id])
    authorize! :manage, @ug
  end
end
