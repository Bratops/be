class V1::GroupController < V1::CacheController
  resource_description do
    api_versions "1.0"
    short "Group related interface"
  end
  skip_before_filter :authenticate_user_from_token!, :only => [:publist]

  def publist
    #redirect_to "https://www.facebook.com/dialog/oauth?client_id=437619129714738&redirect_uri=http%3A%2F%2Fbrasbe.dev%2Fusers%2Fauth%2Ffacebook%2Fcallback&response_type=code&scope=email&state=72d37e37d563ea27390b4bb7da1df2341518a2c39a006271"
    Rails.cache.delete(publist_key)
    mem = Rails.cache.fetch publist_key do
      if params[:res] == "school"
        sl = Edu::School.where("name like ?", "%#{params[:query]}%").limit(10)
        list_json Common::SchoolSerializer, sl
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
