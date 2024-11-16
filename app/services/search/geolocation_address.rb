module Search
  class GeolocationAddress
    include HTTParty
    base_uri 'https://nominatim.openstreetmap.org'

    attr_reader :latitude, :longitude

    def initialize(latitude:, longitude:)
      @latitude = latitude
      @longitude = longitude
    end

    def call
      reverse_geocode
    end

    private

    def reverse_geocode
      response = self.class.get("/reverse", query: {
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
