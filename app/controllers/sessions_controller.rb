class SessionsController < ApplicationController
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
    set_session(response_body['access_token'])
    redirect_to('/')
  end

  def delete
    reset_session
    redirect_to(root_path)
  end

  def set_session(value)
    session[:token] = value
  end
end
