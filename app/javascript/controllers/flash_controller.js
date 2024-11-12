import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => {
      this.element.classList.add("d-none");
    }, 2000);
  }

  disconnect() {
    clearTimeout(this.timeout);
  }
}
