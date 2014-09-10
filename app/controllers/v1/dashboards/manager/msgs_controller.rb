class V1::Dashboards::Manager::MsgsController < V1::BaseController
  include V1::FrontendHelper
  before_filter :auth

  def create
    msg = Msg.new(msg_params)
    data = nil
    if msg.save
      data = MsgSerializer.new(msg)
      state = "success"
    else
      state = "error"
    end
    render json: { data: data, msg: cmsg(state) }
  end

  def index
    msgs = Msg.all
    msgs = ActiveModel::ArraySerializer.new(msgs, each_serializer: MsgSerializer)
    render json: msgs
  end

  def update
    msg = Msg.find_by_id(params[:id])
    if msg && msg.update(msg_params)
      state = "success"
    else
      state = "error"
    end
    render json: { msg: cmsg(state) }
  end

  def destroy
    msg = Msg.find_by_id(params[:id])
    if msg && msg.delete
      state = "success"
    else
      state = "error"
    end
    render json: { id: params[:id].to_i, msg: cmsg(state) }
  end

  private
  def auth
    authorize! :manage, Msg
  end

  def msg_params
    params.require(:msg).permit(:start_time, :end_time, :title, :body)
  end
end
