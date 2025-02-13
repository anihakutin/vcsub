import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source"]

  connect() {
    console.log("Clipboard controller connected")
  }

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.value)
      .then(() => {
        const toast = document.createElement('div')
        toast.className = 'fixed bottom-4 right-4 bg-gray-900 text-white px-4 py-2 rounded-lg shadow-lg z-50'
        toast.textContent = 'Copied to clipboard!'
        document.body.appendChild(toast)

        setTimeout(() => toast.remove(), 2000)
      })
      .catch(err => console.error('Failed to copy:', err))
  }
}