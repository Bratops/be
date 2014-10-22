class V1::Dashboards::Manager::EdusController < V1::BaseController
  include V1::MessageHelper
  before_filter :setup

  def list
    load_items
    aas = ActiveModel::ArraySerializer
    mts = ::Manager::Edus::ListSerializer
    render json: aas.new(@items, each_serializer: mts)
  end

  def details
    data = model.find(params[:id])
    jd = serializer.new(data, scope: {pager: pager, user: current_user})
    render json: jd
  end

  private

  def setup
    authorize! :manage, Survey
    @sta = :error
  end

  def model
    klass_str = "Edu::#{params[:type].capitalize}"
    klass_str.singularize.classify.constantize
  end

  def serializer
    klass_str = "Manager::Edus::#{params[:type].capitalize}Serializer"
    klass_str.singularize.classify.constantize
  end

  def load_items
    items = model.where("name like ?", "%#{params[:query]}%").first(20)
    @items = items ? items : []
  end

  def pager
    params.require(:pager).permit(:page, :per_page)
  end
end
