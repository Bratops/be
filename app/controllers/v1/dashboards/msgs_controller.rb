class V1::Dashboards::MsgsController < V1::BaseController
  def index
    msgs = Msg.all
    msgs = ActiveModel::ArraySerializer.new(msgs, each_serializer: MsgSerializer)
    render json: msgs
  end
end
