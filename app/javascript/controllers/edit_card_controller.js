import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['card', 'form']

  connect() {
  }

  toggle() {
    this.cardTarget.classList.toggle('active')
    this.formTarget.classList.toggle('active')
  }
}
