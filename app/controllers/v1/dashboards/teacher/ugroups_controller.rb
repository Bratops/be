class V1::Dashboards::Teacher::UgroupsController < V1::BaseController
  include V1::MessageHelper
  include V1::Teacher::UgroupCRUD
  before_filter :auth, except: [:index, :create, :clusters]

  def clusters
    items = Edu::Cluster.all
    us = ActiveModel::ArraySerializer.new(
      items, each_serializer: ::Teacher::ClusterSerializer)
    render json: us
  end

  def enrolls
    ens = @ug.enrollments
    ens = ActiveModel::ArraySerializer.new(ens, each_serializer: EnrollmentSerializer)
    render json: ens
  end

  def reset_passwords
    ugroup = Edu::Ugroup.with_role(:teacher, current_user).find_by(id: params[:id])
    ugroup.enrollments.each do |en|
      en.reset_password
    end
    render json: {
      msg: cmsg(:success)
    }
  end

  def enroll
    ero = {}
    eid = nil
    sts = no_res @ug do
      en = @ug.update_enrollment user_params
      eid = en.id
      if en.errors.blank?
        sts = (en.created_at == en.updated_at) ? :success : :updated
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
          value: [:success, :updated].include?(sts) ? "added" : "error"
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

  def auth
    @ug = Edu::Ugroup.find_by_id(params[:id])
    authorize! :manage, @ug
  end
end
