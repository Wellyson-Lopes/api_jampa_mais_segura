import { Controller } from "@hotwired/stimulus";
import L from "leaflet";
import "leaflet.heat";

export default class extends Controller {
  static values = { points: Array, center: Object }

  connect() {
    const { lat, lng, zoom } = this.centerValue;

    this.map = L.map(this.element).setView([lat, lng], zoom);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map);

    const heatPoints = this.pointsValue
      .filter(point => point.lat && point.lng)
      .map(point => [point.lat, point.lng]);

    if (heatPoints.length) {
      L.heatLayer(heatPoints, {
        radius: 50,
        blur: 75,
        maxZoom: 12,
        minOpacity: 0.2,
        max: 1.0,
        gradient: {
          0.2: 'blue',
          0.5: 'lime',
          0.7: 'yellow',
          1.0: 'red'
        }
      }).addTo(this.map);
    }

    this.pointsValue.forEach(point => {
      if (point.lat && point.lng) {
        const marker = L.marker([point.lat, point.lng]).addTo(this.map);

        if (point.popup) {
          marker.bindPopup(point.popup);
        }
      }
    });
  }
}
