import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['card', 'form']

  connect() {
  }

  toggle() {
    this.cardTarget.classList.toggle('flex')
    this.cardTarget.classList.toggle('hidden')

    this.formTarget.classList.toggle('hidden')
    this.formTarget.classList.toggle('flex')
  }
}
