class V1::Dashboards::User::ContestsController < V1::BaseController
  include V1::MessageHelper
  before_filter :setup, except: [:index]

  def index
    cns = Contest::Info.all
    us = ActiveModel::ArraySerializer.new(cns, each_serializer: ::User::ContestInfoSerializer)
    render json: us
  end

  private

  def setup
  end
end
