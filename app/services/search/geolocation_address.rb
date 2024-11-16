module Search
  class GeolocationAddress
    include HTTParty
    base_uri 'https://us1.locationiq.com'

    attr_reader :latitude, :longitude, :api_key

    def initialize(latitude:, longitude:)
      @latitude = latitude
      @longitude = longitude
      @api_key = ENV['MAP_SECRET_API_KEY']
    end

    def call
      reverse_geocode
    end

    private

    def reverse_geocode
      response = self.class.get("/v1/reverse", query: {
                                  key: api_key,
                                  lat: latitude,
                                  lon: longitude,
                                  format: 'json'
                                })

      if response.success?
        {
          address: response["address"]["road"],
          district: response["address"]["suburb"],
          city: response["address"]["city"]
        }
      else
        { error: "Erro ao buscar endereço", status: response.code }
      end
    rescue StandardError => e
      Rails.logger.error("Erro ao buscar endereço: #{e.message}")
      { error: "Erro inesperado", message: e.message }
    end
  end
end
