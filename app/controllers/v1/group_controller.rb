class V1::GroupController < V1::CacheController
  resource_description do
    api_versions "1.0"
    short "Group related interface"
  end
  skip_before_filter :authenticate_user_from_token!, :only => [:publist]

  def publist
    Rails.cache.delete(publist_key)
    mem = Rails.cache.fetch publist_key do
      if params[:res] == "school"
        sl = School.where("name like ?", "%#{params[:query]}%").limit(10)
        list_json SimpleSchoolSerializer, sl
      end
    end
    render json: mem
  end

  private
  def publist_key
    "#{controller_name}.#{action_name}.#{params[:res]}.#{params[:query]}"
  end

  def list_json serializer, data
    aas = ActiveModel::ArraySerializer
    aas.new(data, each_serializer: serializer).to_json
  end
end
