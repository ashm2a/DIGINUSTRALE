import { Controller } from "@hotwired/stimulus"
import { end } from "@popperjs/core";

// Connects to data-controller="aop"
export default class extends Controller {

  static targets = ["output", "poids", "lard", "ph", "row", "decoupe", "eligible"]
  connect () {
  }
  clickUpdatePorcs() {
    const rowElements = document.querySelectorAll('[data-aop-target="row"]');
    //const btnDecoupeElement = document.querySelector('[data-aop-target="btn-decoupe"]');
    const decoupeBtn = document.querySelector(".decoupe a");
    //console.log(decoupeBtn);

    //decoupeBtn.classList.remove("d-none");

    rowElements.forEach((rowElement) => {
      const poidsValue = parseFloat(rowElement.querySelector('[data-aop-target="poids"]').value);
      const lardValue = parseFloat(rowElement.querySelector('[data-aop-target="lard"]').value);
      const phValue = parseFloat(rowElement.querySelector('[data-aop-target="ph"]').value);
      const imgElement = rowElement.querySelector('[data-aop-target="output"]');
      //const eligible = rowElement.querySelector('[data-aop-target="eligible"]');

      if(poidsValue != null && lardValue != null && phValue != null) {
        decoupeBtn.classList.remove('d-none');
      }
        if(

          ((poidsValue >= 80) && (poidsValue <= 140))
          &&
          ((lardValue >= 4) && (lardValue <= 6))
          &&
          ((phValue >= 4) && (phValue <= 6))
        ) {
          //console.log("AOP OK")
          imgElement.querySelector("img").classList.remove("d-none");
          rowElement.classList.add("bg-success");
          }
        else {
          //console.log("AOP NO")
          imgElement.querySelector("img").classList.add("d-none");
          rowElement.classList.remove("bg-success");
        }
        end
      end
    });
  }
}
