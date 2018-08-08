import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["front", "back", "showResponseButton", "responseButtons"]

  connect() {
    this.load()
  }

  showCard() {
    // Display the front of the card
    this.frontTarget.textContent = this.currentCard.front

    // Populate the back of the card and hide it
    this.backTarget.textContent = ""
  }

  showResponse() {
    // Display response
    this.backTarget.textContent = this.currentCard.back

    // Hide 'Show Response' and show response buttons
    this.showResponseButtonTarget.style.display = 'none'
    this.responseButtonsTarget.style.display = 'block'
  }

  load() {
    fetch(this.data.get('url'))
      .then(response => response.json())
      .then(json => {
        this.currentCard = json
        this.showCard()
      })
  }
}
