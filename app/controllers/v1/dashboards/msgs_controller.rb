class V1::Dashboards::MsgsController < V1::BaseController
  skip_before_filter :authenticate_user_from_token!, :only => [:index]
  def index
    msgs = Msg.all
    msgs = ActiveModel::ArraySerializer.new(msgs, each_serializer: MsgSerializer)
    render json: msgs
  end
end
