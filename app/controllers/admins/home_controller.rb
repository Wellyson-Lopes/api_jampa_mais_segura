module Admins
  class HomeController < Admins::ApplicationAdminController
    def index
      @ocorrencias = Incident.all
      @dados = @ocorrencias.map do |ocorrencia|
        {
          lat: ocorrencia.latitude,
          lng: ocorrencia.longitude,
          popup: 'Informação opcional'
        }
      end
      @incidents = Incident.joins(:crime_type)
                           .group('crime_types.name')
                           .count
    end
  end
end
