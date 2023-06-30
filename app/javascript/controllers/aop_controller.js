import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="aop"
export default class extends Controller {

  static targets = ["output", "poids", "lard", "ph", "row"]
  connect () {
  }
  clickUpdatePorcs() {
    const rowElements = document.querySelectorAll('[data-aop-target="row"]');

    rowElements.forEach((rowElement) => {
      const poidsValue = parseFloat(rowElement.querySelector('[data-aop-target="poids"]').value);
      //console.log(typeof poidsValue);


      const lardValue = parseFloat(rowElement.querySelector('[data-aop-target="lard"]').value);
      //console.log(lardValue);
      const phValue = parseFloat(rowElement.querySelector('[data-aop-target="ph"]').value);
      //console.log(phValue);

      const imgElement = rowElement.querySelector('[data-aop-target="output"]');
      console.log(imgElement.querySelector("img"));

      if(
        ((poidsValue >= 80) && (poidsValue <= 140))
        &&
        ((lardValue >= 4) && (lardValue <= 6))
        &&
        ((phValue >= 4) && (phValue <= 6))
      ) {console.log("AOP OK")
        imgElement.querySelector("img").classList.remove("d-none");
         }
      else {
        console.log("AOP NO")
        imgElement.querySelector("img").classList.add("d-none");
      }


    });
  }
}
