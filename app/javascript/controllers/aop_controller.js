import { Controller } from "@hotwired/stimulus"
import { beforeMain } from "@popperjs/core";

// Connects to data-controller="aop"
export default class extends Controller {

  static targets = ["bg", "poids", "lard", "ph", "eligible"]

  connect() {
    this.labelAop();
  }

  labelAop() {

    const img = this.eligibleTarget;
    const bg = this.bgTarget;

    const poidsValue = parseFloat(this.poidsTarget.value);
    const lardValue = parseFloat(this.lardTarget.value);
    const phValue = parseFloat(this.phTarget.value);

    if (
      (poidsValue >= 85 && poidsValue <= 140) &&
      (lardValue >= 2.5 && lardValue <= 6) &&
      (phValue >= 5.2 && phValue <= 5.7)
    ) {
        img.classList.remove("d-none");
        bg.classList.add("bg-success");

      } else {
        img.classList.add("d-none");
        bg.classList.remove("bg-success");
    }
  };
}
