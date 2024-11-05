import { Controller } from "@hotwired/stimulus";
import L from "leaflet";
import "leaflet.heat";

export default class extends Controller {
  static values = { points: Array }

  connect() {
    // Inicializa o mapa na div do elemento onde Stimulus está conectado
    this.map = L.map(this.element).setView([-7.179535, -34.919297], 13);

    // Adiciona o tile layer do OpenStreetMap
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map);

    // Valida e extrai os pontos de calor (heatmap)
    const heatPoints = this.pointsValue
      .filter(point => point.lat && point.lng) // Valida se os pontos têm lat/lng
      .map(point => [point.lat, point.lng]);

    if (heatPoints.length) {
      // Adiciona o heatmap com as propriedades ajustadas
      L.heatLayer(heatPoints, {
        radius: 50,            // Tamanho do raio
        blur: 75,              // Desfoque ao redor dos pontos
        maxZoom: 12,           // Zoom máximo onde o heatmap é visível
        minOpacity: 0.2,       // Opacidade mínima
        max: 1.0,              // Intensidade máxima dos pontos
        gradient: {            // Gradiente de cores personalizado
          0.2: 'blue',
          0.5: 'lime',
          0.7: 'yellow',
          1.0: 'red'
        }
      }).addTo(this.map);
    }

    // Adiciona os marcadores no mapa, e busca o bairro de cada ponto
    this.pointsValue.forEach(point => {
      if (point.lat && point.lng) {
        // Adiciona um marcador no mapa
        const marker = L.marker([point.lat, point.lng]).addTo(this.map);

        if (point.popup) {
          marker.bindPopup(point.popup); // Exibe popup se houver
        }

        // Chama a função de geocodificação reversa para cada ponto
        this.getNeighborhood(point.lat, point.lng);
      }
    });
  }

  // Função para obter o bairro de um ponto usando a API de geocodificação reversa do OpenStreetMap
  async getNeighborhood(lat, lng) {
    try {
      const response = await fetch(`https://nominatim.openstreetmap.org/reverse?lat=${lat}&lon=${lng}&format=json`);
      const data = await response.json();

      // Log dos dados retornados
      // console.log("Dados retornados pela geocodificação reversa:", data);

      // Verifica se existe um bairro (suburb) ou localidade (residential) na resposta
      if (data.address && data.address.suburb) {
        console.log(`O ponto em ${lat}, ${lng} está no bairro: ${data.address.suburb}`);
      } else if (data.address && data.address.residential) {
        console.log(`O ponto em ${lat}, ${lng} está na localidade: ${data.address.residential}`);
      } else {
        console.log(`O ponto em ${lat}, ${lng} não pôde determinar o bairro.`);
      }
    } catch (error) {
      console.error("Erro ao buscar o bairro:", error);
    }
  }
}
