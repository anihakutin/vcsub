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
        toast.className = `
          fixed top-4 left-1/2 -translate-x-1/2 
          bg-gray-900 text-white 
          px-4 py-2 
          rounded-lg shadow-lg 
          z-50
          animate-fade-in-down
          max-w-[90%] md:max-w-md
          text-center
          text-sm md:text-base
        `
        toast.textContent = 'Copied to clipboard!'
        document.body.appendChild(toast)

        // Fade out animation
        setTimeout(() => {
          toast.classList.add('animate-fade-out-up')
          setTimeout(() => toast.remove(), 300)
        }, 2000)
      })
      .catch(err => console.error('Failed to copy:', err))
  }
}