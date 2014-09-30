class V1::Dashboards::Manager::FilesController < V1::BaseController
  include V1::MessageHelper
  before_filter :setup
  skip_before_filter :authenticate_user_from_token!, only: [:download]

  def upload_info
    # flow testChunk true
    render status: 201, json: ""
  end

  def upload
    sf = SysFile.create(name: params[:flowFilename], down_count: 0)
    sf.share = params[:file]
    data = nil
    @sta = :error
    if sf.save
      @sta = :success
      data = ::Manager::SysFileSerializer.new(sf)
    else
      sf.destroy
    end
    render status: 200, json: {
      msg: tmsg(@sta, current_user.xrole.name),
      data: data
    }
  end

  def index
    files = SysFile.all
    render json: ActiveModel::ArraySerializer.
      new(files, each_serializer: ::Manager::SysFileSerializer)
  end

  def destroy
    file = SysFile.find_by_fcode(params[:id])
    if file.destroy
      @sta = :success
    end
    render status: 200, json: { status: @sta }
  end

  def download
    file = SysFile.find_by_fcode(params[:code])
    file.update(down_count: file.down_count + 1)
    send_file file.share.path, x_sendfile: true
  end

  private

  def setup
    authorize! :manage, SysFile
    @sta = :error
  end
end
