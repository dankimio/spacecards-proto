import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['formContainer']

  connect() {}

  addForm(event) {
    event.preventDefault()

    // Clone form template
    let newForm = this.formContainerTarget.cloneNode(true)
    // Insert and show
    this.formContainerTarget.after(newForm)
    newForm.classList.remove('hidden')
    newForm.querySelector('#card_front').focus()
  }

  submit(event) {
    event.preventDefault()

    let currentForm = event.target.parentNode
    let formContainer = currentForm.parentNode

    if (currentForm.checkValidity()) {
      formContainer.classList.add('hidden')
      Rails.fire(currentForm, 'submit')
    } else {
      currentForm.querySelector('input[type="submit"]').click()
    }
  }

  cancel(event) {
    event.preventDefault()

    let currentForm = event.target.parentNode
    let formContainer = currentForm.parentNode
    formContainer.parentNode.removeChild(formContainer)
  }
}
