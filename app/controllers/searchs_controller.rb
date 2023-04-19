class SearchsController < ApplicationController 
  def new
  end

  def search
    search_results = OmdbApi.new.search({ :s => params[:search] })
    @response = JSON.parse(search_results.body)
  end
end
