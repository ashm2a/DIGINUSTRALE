import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="produit-aop"
export default class extends Controller {
  static targets = ["porc", "alert", "poids", "misesel", "sortiesel", "fumage", "sortieseche", "entreeaffinage", "sortieaffinage", "img", "bg"]
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
    //CRITERES

  //console.log(this.poidsTarget.value);
//console.log();

  //mise au sel max 3 jours après abattage
  const dateAbattage = this.miseselTarget.attributes[6].value;
  const condiMiseSel = (new Date(this.miseselTarget.value) - new Date(dateAbattage)) / (24 * 60 * 60 * 1000) <= 3;

  //1.5 à 2 jours de salage
  const condiSortieSel = (new Date(this.sortieselTarget.value) - new Date(this.miseselTarget.value)) / (24 * 60 * 60 * 1000) >= 1.5 && (new Date(this.sortieselTarget.value) - new Date(this.miseselTarget.value)) / (24 * 60 * 60 * 1000) <= 2;

  //max 7j de fumage
  const condiFumage = this.fumageTarget.value <= 7

  //poids sortie sèche doit avoir diminué de 25% par rapport au poids frais
  const condiSortieseche = (this.sortiesecheTarget.value <= (0.75 * this.poidsTarget.value))

  //au moins 2 mois d'affinage
  const condiAffinage = (new Date(this.sortieaffinageTarget.value) - new Date(this.entreeaffinageTarget.value)) / (24 * 60 * 60 * 1000) >= 60;
  console.log(condiAffinage);

  //vérifier les crtières et ajouter la condition du porc
  if (condiMiseSel && condiSortieSel && condiFumage && condiSortieseche && condiAffinage && (!this.alertTarget.classList.contains("d-none"))) {
  //appliquer le style
  {
    img.classList.remove("d-none");
    bg.classList.add("bg-success");

  } else {
    img.classList.add("d-none");
    bg.classList.remove("bg-success");
    }

// }

  };
};
