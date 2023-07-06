import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="produit-aop"
export default class extends Controller {
  static targets = ["porc", "alert", "poids", "mise-sel", "sortie-sel", "fumage", "sortie-seche", "entree-affinage", "sortie-affinage", "img", "bg"]
//targets edit_coppa... = produitAopcontroller : vérifier si porc eli quand select porcAop , puis vérif si produit eli labelAop

  connect() {
    this.porcAop()
    this.produitAop()
  }

  porcAop() {
    if (this.porcTarget.selectedOptions && this.porcTarget.selectedOptions.length) {
      if (this.porcTarget.selectedOptions[0].dataset.eligible === "true")  {
        this.alertTarget.classList.remove("d-none")
      } else {
        this.alertTarget.classList.add("d-none")
      }
    }
  }

  produitAop() {
    //define values (nbr de jours, etc....)
// console.log(this.poidsTarget.value);
// console.log(this.miseSelTarget);
// console.log(this.sortieSelTarget.value);
// console.log(this.fumageTarget.value);
// console.log(this.sortieSechelTarget.value);
// console.log(this.entreeAffinageTarget.value);
// console.log(this.sortieAffinageTarget.value);

    // const poidsValue = parseFloat(this.poidsTarget.value);
    // const lardValue = parseFloat(this.miseSelTarget.value);
    // const phValue = parseFloat(this.sortieSelTarget.value);
    // const phValue = parseFloat(this.fumageTarget.value);
    // const phValue = parseFloat(this.sortieSechelTarget.value);
    // const phValue = parseFloat(this.entreeAffinageTarget.value);
    // const phValue = parseFloat(this.sortieAffinageTarget.value);


  //vérifier les crtières
// if (
    //   (poidsValue >= 85 && poidsValue <= 140) &&
    //   (lardValue >= 2.5 && lardValue <= 6) &&
    //   (phValue >= 5.2 && phValue <= 5.7) &&

    //ajouter la condition du porc
&& (!this.alertTarget.classList.contains("d-none")) {

}

  //appliquer le style

    // ) {
    //     img.classList.remove("d-none");
    //     bg.classList.add("bg-success");

    //   } else {
    //     img.classList.add("d-none");
    //     bg.classList.remove("bg-success");
    // }
  };
}
