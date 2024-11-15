module Admins
  class HomeController < Admins::ApplicationAdminController
    before_action :set_dados, only: %i[index map]
    def index; end

    def map; end

    private

    def set_dados
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
