import { Controller } from "@hotwired/stimulus";

/**
 * Toggles the `data-toggle-class-value` (defaults to `hidden`) on the HTMLElement
 * `togglee`.
 *
 * @example
 *  <div data-controller="class-toggle" data-toggle-class-value="hidden">
 *    <button data-class-toggle-target="toggler">Click</button>
 *    <div data-class-toggle-target="togglee" class="hidden">Hidden at first</div>
 *  </div>
 * 
 * @property {HTMLElement} togglerTarget
 * @property {HTMLElement} toggleeTarget
 */
export default class extends Controller {
  static values = {
    toggleId: String,
    toggleClass: { type: String, default: "hidden" },
  };  

  toggle() {
    var togglee = document.getElementById(this.toggleIdValue);

    if (!!togglee) {
      togglee.classList.toggle(this.toggleClassValue);
    }
  }
}
