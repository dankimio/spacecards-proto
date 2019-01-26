import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['button', 'content']

  connect() {}

  toggle(event) {
    event.preventDefault()

    this.contentTarget.classList.toggle('active')

    if (this.buttonTarget.textContent === '+') {
      this.buttonTarget.textContent = '−'
    } else {
      this.buttonTarget.textContent = '+'
    }
  }
}
