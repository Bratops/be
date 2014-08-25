class V1::BaseController < ApplicationController
  respond_to :json
  respond_to :html, only: []
  respond_to :xml, only: []

  resource_description do
    api_versions "1.0", "2.1"
    short "Bebras Base API version"
  end
end
