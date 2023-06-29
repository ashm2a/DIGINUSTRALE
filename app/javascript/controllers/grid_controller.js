import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["grid", "button", "bar", "form"];

  connect() {
    const gap = 20;
    const buttons = this.buttonTargets;
    const activeButton = Array.from(buttons).find((button) =>
      button.classList.contains("active")
    );

    const bar = this.barTarget;

    if (activeButton) {
      const activeButtonRect = activeButton.getBoundingClientRect();
      const offsetLeft =
        activeButtonRect.left -
        bar.parentNode.getBoundingClientRect().left;

      bar.style.width = `${activeButtonRect.width + gap - 2}px`;
      bar.style.left = `${offsetLeft}px`;
    } else {
      bar.style.width = "0";
      bar.style.left = "0";
    }

    this.restoreActiveTab();
    this.restoreActiveButton();
  }

  saveActiveTab() {
    const activeTab = document.querySelector(".search.active");
    if (activeTab) {
      const activeTabIndex = Array.from(activeTab.parentNode.children).indexOf(
        activeTab
      );
      localStorage.setItem("activeTab", activeTabIndex);
    }
  }

  saveActiveButton() {
    const activeButton = document.querySelector(".option-left p.active");
    if (activeButton) {
      const activeButtonIndex = Array.from(
        activeButton.parentNode.children
      ).indexOf(activeButton);
      localStorage.setItem("activeButton", activeButtonIndex);
    }
  }

  restoreActiveTab() {
    const activeTabIndex = localStorage.getItem("activeTab");
    if (activeTabIndex) {
      const tabs = Array.from(this.element.querySelectorAll(".search"));
      const tabToActivate = tabs[activeTabIndex];

      if (tabToActivate) {
        const buttons = this.buttonTargets;
        const grids = this.gridTargets;
        const forms = this.formTargets;

        buttons.forEach((button) => button.classList.remove("active"));
        tabToActivate.classList.add("active");

        const tabIndex = Array.from(
          tabToActivate.parentNode.children
        ).indexOf(tabToActivate);

        grids.forEach((grid) => grid.classList.remove("enable"));
        grids[tabIndex].classList.add("enable");

        forms.forEach((form) => form.classList.remove("active"));
        forms[tabIndex].classList.add("active");

        const bar = this.barTarget;
        const activeButtonRect = buttons[tabIndex].getBoundingClientRect();
        const offsetLeft =
          activeButtonRect.left -
          bar.parentNode.getBoundingClientRect().left;

        bar.style.width = `${activeButtonRect.width + 20 - 2}px`;
        bar.style.left = `${offsetLeft}px`;
      }
    }
  }

  restoreActiveButton() {
    const activeButtonIndex = localStorage.getItem("activeButton");
    if (activeButtonIndex) {
      const buttons = this.buttonTargets;
      const buttonToActivate = buttons[activeButtonIndex];

      if (buttonToActivate) {
        buttons.forEach((button) => button.classList.remove("active"));
        buttonToActivate.classList.add("active");

        const bar = this.barTarget;
        const activeButtonRect = buttonToActivate.getBoundingClientRect();
        const offsetLeft =
          activeButtonRect.left -
          bar.parentNode.getBoundingClientRect().left;

        bar.style.width = `${activeButtonRect.width + 20 - 2}px`;
        bar.style.left = `${offsetLeft}px`;
      }
    }
  }

  toggle(event) {
    const clickedButton = event.target;
    const gridIndex = Array.from(clickedButton.parentNode.children).indexOf(
      clickedButton
    );

    const buttons = this.buttonTargets;
    const previousIndex = buttons.findIndex((button) =>
      button.classList.contains("active")
    );

    buttons.forEach((button) => button.classList.remove("active"));
    clickedButton.classList.add("active");

    const grids = this.gridTargets;
    grids.forEach((grid) => grid.classList.remove("enable"));
    grids[gridIndex].classList.add("enable");

    const forms = this.formTargets;
    forms.forEach((form) => form.classList.remove("active"));
    forms[gridIndex].classList.add("active");

    const bar = this.barTarget;
    const buttonRect = clickedButton.getBoundingClientRect();

    const offsetLeft =
      buttonRect.left - bar.parentNode.getBoundingClientRect().left;
    const offset = offsetLeft;

    bar.style.left = `${offset}px`;
    bar.style.width = `${buttonRect.width}px`;

    // Ajouter une transition pour créer un effet de glissement
    bar.style.transition = "left 0.3s ease, width 0.3s ease";

    this.saveActiveTab();
    this.saveActiveButton();
  }
}
