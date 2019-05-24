class RepositoriesController < ApplicationController
  def index
    @search_terms = params[:search_terms]

    results = Faraday.get(dynamic_query)
    @repos = JSON.parse(results.body)
  end

  def search
  end

  private

  def dynamic_query
    URI.escape "#{github_base_api_url}search/repositories?q=#{formatted_query}"
  end

  def formatted_query
    return '' unless @search_terms

    @search_terms.split(',').map(&:strip).join('+')
  end

  def github_base_api_url
    'https://api.github.com/'.freeze
  end
end
