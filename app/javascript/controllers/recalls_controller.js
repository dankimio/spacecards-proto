import { Controller } from 'stimulus'
import ApplicationHelper from '../helpers/application_helper'

export default class extends Controller {
  static targets = [
    'card',
    'front',
    'back',
    'showBackButton',
    'responseButtons',
    'stats',
    'cardsCount',
    'deckProgress'
  ]

  initialize() {
    this.cardsCount = 0
    this.answerShown = false

    this.configureShortcuts()
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
    this.frontTarget.innerHTML = this.currentCard.front_html
    this.hideBack()
  }

  showBack(event) {
    if (event) {
      event.preventDefault()
    }

    if (this.answerShown) {
      return
    }
    this.answerShown = true

    this.backTarget.classList.add('active')
    this.backTarget.innerHTML = this.currentCard.back_html

    this.cardTarget.classList.add('animated', 'flipInX', 'faster')

    this.showBackButtonTarget.style.display = 'none'
    this.responseButtonsTarget.style.display = 'block'
  }

  hideBack() {
    this.backTarget.classList.remove('active')
    this.backTarget.textContent = ''

    this.showBackButtonTarget.style.display = 'inline-block'
    this.responseButtonsTarget.style.display = 'none'
  }

  // Hide everything and show 'No cards left' message
  finish() {
    this.cardsCountTarget.textContent = this.cardsCount

    this.showBackButtonTarget.style.display = 'none'
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

    this.cardTarget.classList.remove('animated', 'flipInX', 'faster')

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
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': ApplicationHelper.getMetaValue('csrf-token')
      }
    })
    .catch(error => alert(error))

    this.cards = this.cards.filter(item => item !== this.currentCard)
    this.currentCard = this.cards[0]
    if (this.currentCard) {
      this.showCard()
    } else {
      this.load()
    }
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

  configureShortcuts() {
    document.onkeyup = event => {
      switch (event.keyCode) {
        case 13:
          this.showBack()
          break
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
}
