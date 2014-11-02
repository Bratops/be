class V1::Dashboards::Teacher::ConregsController < V1::BaseController
  include V1::MessageHelper

  def index
    load_current_regs
    regs = ActiveModel::ArraySerializer.new(@regs, each_serializer: ::Teacher::ContestRegSerializer)
    render json: regs
  end

  def create
    @con = Contest::Reg.find_or_create_by(unique_reg)
    update_conreg
    render json: { msg: cmsg(@sta) }
  end

  def update
    @con = Contest::Reg.find_by(params[:id])
    update_conreg
    render json: { msg: cmsg(@sta) }
  end

  def destroy
    @con = Contest::Reg.find_by(id: params[:id])
    @sta = :success if @con.destroy
    render json: { msg: cmsg(@sta) }
  end

  private

  def setup
    @sta = :error
  end

  def update_conreg
    if @con.errors.size == 0
      @con.update(conreg_details)
      @sta = :success
    end
  end

  def conreg_details
    params.require(:conreg).permit(:contest_id, :exdate, :extime)
  end

  def conreg_params
    params.require(:conreg).permit(:contest_id)
  end

  def conreg_query
    params.permit(:gcode, :contest_id, :exdate, :extime)
  end

  def unique_reg
    cp = conreg_params
    cp[:ugroup_id] = find_ugroup_id
    cp
  end

  def find_ugroup_id
    Edu::Ugroup.find_by(gcode: params[:conreg][:gcode]).id
  end

  def load_current_regs
    @ugroups = Edu::Ugroup.where(conreg_query)
    ugroups = @ugroups.with_role :teacher, current_user
    @regs = Contest::Reg.where(ugroup_id: ugroups.ids)
  end
end
