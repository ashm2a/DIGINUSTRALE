import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['checkbox', 'block'];

  connect() {
    if (this.checkboxTarget.checked) {
      this.blockTarget.classList.remove("d-none");
    }
  }

  toggleDateDeces() {

    if (this.checkboxTarget.checked) {
      this.blockTarget.classList.remove("d-none");
    } else {
      this.blockTarget.classList.add("d-none");
    }
  }
}
