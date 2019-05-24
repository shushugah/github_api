class ApplicationController < ActionController::Base
  before_action :authenticate_user


  def authenticate_user
    redirect_to github_auth_url unless signed_in?
  end

  private

  def signed_in?
    !!session[:token]
  end

  def github_credentials
    Rails.application.credentials.github
  end

  def github_auth_url
    "https://github.com/login/oauth/authorize?client_id=#{github_credentials[:client_id]}"
  end
end
