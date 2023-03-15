class SearchsController < ApplicationController 
  def new
  end

  def search
    api_instance = OmdbApi.new
    search_results = api_instance.search({ :s => params[:search] })
    @response = JSON.parse(search_results.body)
  end
end
