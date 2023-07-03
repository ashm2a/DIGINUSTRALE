import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list", "select"];

  connect() {
    this.updateList();
    this.disableSelectedOptions();
  }

  initialize() {
    // Désélectionner la première option lors du chargement de la page
    this.selectTarget.options[0].selected = false;
  }

  updateList() {
    const selectedOption = this.selectTarget.selectedOptions[0];

    if (selectedOption && selectedOption.value) {
      const porcId = selectedOption.value;
      const porcText = selectedOption.text;

      const newPorcItem = document.createElement("div");
      newPorcItem.dataset.porcId = porcId;
      newPorcItem.textContent = porcText;

      const deleteButton = document.createElement("button");
      deleteButton.textContent = "x";
      deleteButton.addEventListener("click", () => {
        newPorcItem.remove();
        this.enableOption(porcId);
      });

      newPorcItem.appendChild(deleteButton);
      this.listTarget.appendChild(newPorcItem);

      this.disableOption(porcId);
    }

    const ids = document.querySelectorAll('[data-porc-id]');
    const porcIds = Array.from(ids).map(item => item.dataset.porcId);

    const porcIdsInput = document.getElementById('porc-ids-input');
    porcIdsInput.value = porcIds.join(',');
  }

  disableOption(porcId) {
    const option = this.selectTarget.querySelector(`option[value="${porcId}"]`);
    if (option) {
      option.disabled = true;
    }
  }

  enableOption(porcId) {
    const option = this.selectTarget.querySelector(`option[value="${porcId}"]`);
    if (option) {
      option.disabled = false;
    }
  }

  disableSelectedOptions() {
    const selectedOptions = Array.from(this.selectTarget.selectedOptions);
    selectedOptions.forEach((option) => {
      const porcId = option.value;
      this.disableOption(porcId);
    });
  }
}
