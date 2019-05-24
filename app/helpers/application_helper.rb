module ApplicationHelper
  def review_github_credentials_url
    link_to('Review Github credentials',
      "https://github.com/settings/connections/applications/#{Rails.application.credentials.github[:client_id]}")
  end
end
