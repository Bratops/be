class V1::BaseController < ApplicationController
  resource_description do
    api_versions "1.0", "2.1"
    short "Bebras Base API version"
    meta author: { name: "Speed.of.light" }
    param :id, Fixnum, :desc => "User ID", :required => false
  end
end
