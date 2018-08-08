import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['front', 'back', 'showResponseButton', 'responseButtons']

  connect() {
    this.load()
  }

  showCard() {
    if (!this.currentCard) {
      // Hide everything
      this.frontTarget.style.display = 'none'
      this.backTarget.textContent = 'No cards left!'
      this.showResponseButtonTarget.style.display = 'none'
      this.responseButtonsTarget.style.display = 'none'

      return
    }

    // Display the front of the card
    this.frontTarget.textContent = this.currentCard.front

    // Populate the back of the card and hide it
    this.backTarget.textContent = ''
  }

  showResponse() {
    // Display response
    this.backTarget.textContent = this.currentCard.back

    // Hide 'Show Response' and show response buttons
    this.showResponseButtonTarget.style.display = 'none'
    this.responseButtonsTarget.style.display = 'block'
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
        this.showCard()
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
        this.showCard()
      })
  }
}

function getMetaValue(name) {
  const element = document.head.querySelector(`meta[name="${name}"]`)
  return element.getAttribute('content')
}
