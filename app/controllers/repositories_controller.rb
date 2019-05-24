class RepositoriesController < ApplicationController
  def index
    @coding_languages = params[:coding_languages]
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

    (@search_terms.split(',').map(&:strip) + structured_coding_languages).join('+')
  end

  end

  def github_base_api_url
    'https://api.github.com/'.freeze
  end

  def structured_coding_languages
    Array(@coding_languages&.map {|lang| "language:#{lang}"})
  end
end
