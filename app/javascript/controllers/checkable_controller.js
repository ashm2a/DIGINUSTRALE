import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["decoupe", "checkable"]

  connect () {
    this.validateForm();
  }

  validateForm() {
    //console.log(this.checkableTargets);
    // this.checkableTargets.forEach((target) => {
    //   console.log(target);
    //   console.log(target.value.length);
    // })

    const formIsValid = this.checkableTargets.every((target) => {
      return target.value.length > 0
    })
    if (formIsValid) {
      this.decoupeTarget.classList.remove('d-none');
      //console.log("form is full");
    } else {
      this.decoupeTarget.classList.add('d-none');
      //console.log("some fields left");
    }
  }
}
