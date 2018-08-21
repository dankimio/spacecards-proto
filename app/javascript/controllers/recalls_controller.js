import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [
    'card', 'front', 'back',
    'showResponseButton', 'responseButtons',
    'stats', 'cardsCount', 'deckProgress'
  ]

  initialize() {
    this.cardsCount = 0
    this.answerShown = false

    // Shortcuts
    document.onkeyup = event => {
      switch (event.keyCode) {
        case 13:
          this.showResponse()
          break;
        case 49:
          this.recall(1)
          break
        case 50:
          this.recall(2)
          break
        case 51:
          this.recall(3)
          break
        case 52:
          this.recall(4)
          break
      }
    }
  }

  connect() {
    this.load()
  }

  showCard() {
    if (!this.currentCard) {
      this.finish()
      return
    }

    // Display the front of the card
    this.frontTarget.innerHTML =this.currentCard.front_html
    this.hideResponse()
  }

  showResponse() {
    if (this.answerShown) {
      return
    }
    this.answerShown = true

    this.backTarget.classList.add('active')
    this.backTarget.innerHTML = this.currentCard.back_html

    this.showResponseButtonTarget.style.display = 'none'
    this.responseButtonsTarget.style.display = 'block'
  }

  hideResponse() {
    this.backTarget.classList.remove('active')
    this.backTarget.textContent = ''

    this.showResponseButtonTarget.style.display = 'inline-block'
    this.responseButtonsTarget.style.display = 'none'
  }

  // Hide everything and show 'No cards left' message
  finish() {
    this.cardsCountTarget.textContent = this.cardsCount

    this.showResponseButtonTarget.style.display = 'none'
    this.responseButtonsTarget.style.display = 'none'

    this.cardTarget.classList.add('hidden')
    this.statsTarget.classList.add('active')
  }

  answer(event) {
    event.preventDefault()

    let quality = event.target.dataset.quality
    this.recall(quality)
  }

  recall(quality) {
    // Skip if answer was not displayed
    if (!this.answerShown) {
      return
    }

    // TODO: refactor
    if (quality > 1) {
      this.cardsCount += 1
    }

    this.answerShown = false

    let formData = new FormData()
    formData.append('card[quality]', quality)
    formData.append('card[id]', this.currentCard.id)

    fetch(this.data.get('post-url'), {
      body: formData,
      credentials: 'same-origin',
      method: 'POST',
      headers: { 'X-CSRF-Token': getMetaValue('csrf-token') }
    })
    .then(response => response.json())
    .then(json => {
      let new_due_at = new Date(json.due_at)
      let now = new Date()

      this.cards = this.cards.filter(item => item !== this.currentCard)
      if (new_due_at.getTime() <= now.getTime()) {
        this.cards.push(this.currentCard)
      }
      this.currentCard = this.cards[0]

      if (this.currentCard) {
        this.showCard()
      } else {
        this.load()
      }
    })
  }

  // Load cards from the server
  load() {
    fetch(this.data.get('get-url'), { credentials: 'same-origin' })
      .then(response => response.json())
      .then(json => {
        this.cards = json
        this.currentCard = this.cards[0]

        if (this.currentCard) {
          this.showCard()
        } else {
          this.finish()
        }
      })
  }
}

// Send CSRF token
function getMetaValue(name) {
  const element = document.head.querySelector(`meta[name="${name}"]`)
  return element.getAttribute('content')
}
