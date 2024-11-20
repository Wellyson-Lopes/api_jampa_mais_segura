module Admins
  class HomeController < Admins::ApplicationAdminController
    before_action :set_dados, only: %i[index map]
    def index; end

    def map
      @map_center = { lat: -7.188447, lng: -34.919385, zoom: 13 }
      @skip_navbar = true
    end

    private

    def set_dados
      @ocorrencias = Incident.all
      @dados = @ocorrencias.map do |ocorrencia|
        {
          lat: ocorrencia.latitude,
          lng: ocorrencia.longitude,
          popup: ocorrencia.address || ocorrencia.district
        }
      end
      @map_center = { lat: -7.170190, lng: -34.854321, zoom: 13 }
      @incidents = Incident.joins(:crime_type)
                           .group('crime_types.name')
                           .count
    end
  end
end
