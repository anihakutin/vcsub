import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "dot"]

  connect() {
    if (this.slideTargets.length > 0) {
      this.showSlide(0)
    }
  }

  prev() {
    const currentIndex = this.slideTargets.findIndex(slide => !slide.classList.contains('hidden'))
    const newIndex = currentIndex <= 0 ? this.slideTargets.length - 1 : currentIndex - 1
    this.showSlide(newIndex)
  }

  next() {
    const currentIndex = this.slideTargets.findIndex(slide => !slide.classList.contains('hidden'))
    const newIndex = currentIndex >= this.slideTargets.length - 1 ? 0 : currentIndex + 1
    this.showSlide(newIndex)
  }

  select(event) {
    const index = this.dotTargets.indexOf(event.currentTarget)
    this.showSlide(index)
  }

  showSlide(index) {
    this.slideTargets.forEach((slide, i) => {
      slide.classList.toggle('hidden', i !== index)
    })

    this.dotTargets.forEach((dot, i) => {
      dot.classList.toggle('bg-indigo-600', i === index)
    })
  }
} 