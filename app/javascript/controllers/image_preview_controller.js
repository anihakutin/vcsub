import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  markForDeletion(event) {
    event.preventDefault()
    const container = this.element
    container.classList.add('hidden')
    this.inputTarget.remove()
  }
} 