import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["grid", "button", "bar"]

  connect() {
      const gap = 20;
      const buttons = this.buttonTargets;
      const activeButton = Array.from(buttons).find((button) => button.classList.contains("active"));

      if (activeButton) {
        const bar = this.barTarget;
        const activeButtonRect = activeButton.getBoundingClientRect();
        const offsetLeft = activeButtonRect.left - bar.parentNode.getBoundingClientRect().left;

        bar.style.width = `${activeButtonRect.width + gap}px`;
        bar.style.left = `${activeButtonRect.left - 25}px`;
      }
  }

  toggle(event) {
    const clickedButton = event.target;
    const gridIndex = Array.from(clickedButton.parentNode.children).indexOf(clickedButton);

    const buttons = this.buttonTargets;
    const previousIndex = buttons.findIndex((button) => button.classList.contains("active"));

    buttons[previousIndex].classList.remove("active");
    clickedButton.classList.add("active");

    const grids = this.gridTargets;
    grids[previousIndex].classList.remove("enable");
    grids[gridIndex].classList.add("enable");

    const bar = this.barTarget;
    const buttonRect = clickedButton.getBoundingClientRect();

    const offsetLeft = buttonRect.left - bar.parentNode.getBoundingClientRect().left;
    const previousButtonWidth = buttons[previousIndex].getBoundingClientRect().width;
    const offset = offsetLeft;

    bar.style.left = `${offset}px`;
    bar.style.width = `${buttonRect.width}px`;

    // Ajouter une transition pour créer un effet de glissement
    bar.style.transition = "left 0.3s ease, width 0.3s ease";
  }
}
