import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["decoupe", "checkable"]

  connect () {
    this.validateForm();
  }

  validateForm() {
    const formIsValid = this.checkableTargets.every((target) => {
      return target.value.length > 0
    })
    if (formIsValid) {
      this.decoupeTarget.classList.remove('d-none');
    } else {
      this.decoupeTarget.classList.add('d-none');
    }
  }
}
