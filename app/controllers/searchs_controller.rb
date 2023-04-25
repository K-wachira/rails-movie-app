class SearchsController < ApplicationController
  def new
  end

  def search
    current_page = params[:page].to_i 
    search_results =
      OmdbApi.new.search(
        { s: params[:search], y: params[:year], type: params[:type], p: current_page + 1 }
      )
    @response = JSON.parse(search_results.body)
  end
end
