import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['front', 'back', 'showResponseButton', 'responseButtons']

  connect() {
    this.load()
  }

  showCard() {
    if (!this.currentCard) {
      this.hide()
      return
    }

    // Display the front of the card
    this.frontTarget.textContent = this.currentCard.front
    // Populate the back of the card and hide it
    this.backTarget.textContent = ''
    // Show 'Show Answer' and show response buttons
    this.showResponseButtonTarget.style.display = 'inline-block'
    this.responseButtonsTarget.style.display = 'none'
  }

  showResponse() {
    // Display response
    this.backTarget.textContent = this.currentCard.back

    // Hide 'Show Response' and show response buttons
    this.showResponseButtonTarget.style.display = 'none'
    this.responseButtonsTarget.style.display = 'block'
  }

  // Hide everything and show 'No cards left' message
  hide() {
    this.frontTarget.style.display = 'none'
    this.backTarget.textContent = 'No cards left!'
    this.showResponseButtonTarget.style.display = 'none'
    this.responseButtonsTarget.style.display = 'none'
  }

  recall(event) {
    let quality = event.target.dataset.quality

    let formData = new FormData()
    formData.append('card[quality]', quality)
    formData.append('card[id]', this.currentCard.id)

    fetch(this.data.get('post-url'), {
      body: formData,
      method: 'POST',
      headers: { 'X-CSRF-Token': getMetaValue('csrf-token') }
    })
    .then(response => {
      if (response.ok) {
        this.cards = this.cards.filter(item => item !== this.currentCard)
        this.currentCard = this.cards[0]

        if (this.currentCard) {
          this.showCard()
        } else {
          this.load()
        }
      }
    })
  }

  // Load cards from the server
  load() {
    fetch(this.data.get('get-url'))
      .then(response => response.json())
      .then(json => {
        this.cards = json
        this.currentCard = this.cards[0]

        if (this.currentCard) {
          this.showCard()
        } else {
          this.hide()
        }
      })
  }
}

// Send CSRF token
function getMetaValue(name) {
  const element = document.head.querySelector(`meta[name="${name}"]`)
  return element.getAttribute('content')
}
