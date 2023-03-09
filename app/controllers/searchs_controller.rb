class SearchsController < ApplicationController 
  def new
  end

  def search
    @conn = Faraday.new(
      url: 'https://www.omdbapi.com/',
      headers: { 'Content-Type' => 'application/json' }
    )
    @response = @conn.get("/") do |req|
        req.params = { :s => params[:search] }
        req.params["apikey"] = Rails.application.credentials.dig(:omdb, :apikey)
    end
    @response = JSON.parse(@response.body)
  end
end
