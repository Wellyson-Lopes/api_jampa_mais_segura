import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chart", "data"];

  connect() {
    const incidentData = JSON.parse(this.dataTarget.dataset.graphIncidents);
    console.log("Dados recebidos:", incidentData);

    if (!incidentData || Object.keys(incidentData).length === 0) {
      console.error("Nenhum dado de incidentes encontrado");
      return;
    }

    const labels = Object.keys(incidentData);
    const series = Object.values(incidentData);

    const options = {
      chart: {
        type: 'pie',
        height: 350
      },
      labels: labels,
      series: series,
      title: {
        text: "Distribuição de Ocorrências"
      }
    };

    if (window.ApexCharts) {
      const chart = new window.ApexCharts(this.chartTarget, options);
      chart.render();
    } else {
      console.error("ApexCharts não está disponível como global");
    }
  }
}
