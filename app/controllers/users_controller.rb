class UsersController < ApplicationController

  def verify_id_token
    id_token = params[:token]
    base = "https://www.googleapis.com/oauth2/v3/tokeninfo?id_token="
    encoded = URI.encode(base + id_token)
    HTTParty.get(encoded)
    render json: {status: "ok"}
  end
end
