import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["back", "showResponseButton", "responseButtons"]

  connect() {
    this.backTarget.textContent = 'Hello, Stimulus!'
  }

  showResponse() {
    this.showResponseButtonTarget.style.display = 'none'
    this.responseButtonsTarget.style.display = 'block'
  }
}
