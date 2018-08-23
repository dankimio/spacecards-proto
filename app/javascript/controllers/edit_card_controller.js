import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['card', 'form', 'formFront', 'formBack']

  connect() {}

  toggle(event) {
    event.preventDefault()

    this.cardTarget.classList.toggle('active')
    this.formTarget.classList.toggle('active')

    this.formFrontTarget.focus()
  }
}
