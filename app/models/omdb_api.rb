class OmdbApi
  def initialize
    @conn = Faraday.new(
      url: 'https://www.omdbapi.com/',
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  def search(search_params)
    @response = @conn.get("/") do |req|
      req.params = search_params
      req.params["apikey"] = Rails.application.credentials.dig(:omdb, :apikey)
    end
    return @response
  end
end
