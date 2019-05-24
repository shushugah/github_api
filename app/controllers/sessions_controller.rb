class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |request|
      request.body = {
        'client_id': github_credentials[:client_id],
        'client_secret': github_credentials[:client_secret],
        'code': params[:code]
      }
      request.headers['Accept'] = 'application/json'
    end

    response_body = JSON.parse(response.body)
    session[:token] = response_body['access_token']

    redirect_to('/')
  end
end
