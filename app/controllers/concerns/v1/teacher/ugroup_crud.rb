module V1::Teacher::UgroupCRUD
  extend ActiveSupport::Concern

  def index
    ugs = Edu::Ugroup.with_role(:teacher, current_user).
      where("edu_ugroups.name like ?", "%#{params[:q]}%").
      order("created_at")
    us = ActiveModel::ArraySerializer.new(ugs, each_serializer: ::Teacher::UgroupSerializer)
    render json: us
  end

  def create
    authorize! :create, Edu::Ugroup
    crud_setup
    create_ugroup
    render json: { msg: cmsg(@sta, @args) }
  end

  def show
    find_group
    @jgroup = ::Teacher::UgroupEditSerializer.new(@group)
    render json: @jgroup
  end

  def update
    find_group
    update_ugroup
    render json: { msg: cmsg(@sta, @args) }
  end

  def destroy
    find_group
    @args = {}
    if @group && @group.delete
      @sta = :success
      @args = { group_name: @gropu.name }
    end
    render json: { msg: cmsg(@sta, @args) }
  end

  private

  def crud_setup
    @sta = :error
  end

  def find_group
    ugs = Edu::Ugroup.with_role(:teacher, current_user)
    @group = ugs.find_by(id: params[:id])
  end

  def ugroup_params
    params.require(:ugroup).permit(
      :name, :cluster_id, :grade, :note,
      enrollments_attributes: [
        :id, :name, :gender, :suid, :seat, :_destroy]
    )
  end

  def update_ugroup
    if @group
      if @group.update(ugroup_params)
        @sta = :success
        @args = { group_name: @group.name }
      else
        @args = { error: @group.errors.messages }
      end
    end
  end

  def create_ugroup
    group = Edu::Ugroup.new(ugroup_params)
    group.school = current_user.current_group.school
    if group.save
      current_user.add_role :teacher, group
      @sta = :success
      @args = { group_name: group.name }
    else
      @args = { error: group.errors.messages }
    end
  end

end
