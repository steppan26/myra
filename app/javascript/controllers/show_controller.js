import { add, Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item"]

  connect() {
    this.itemTarget.classList.add("active");
  }

  next() {
    let active = ""
    this.itemTargets.forEach(element => {
      if (element.classList.contains("active")) {
        active = element
      }
    });
    active.classList.remove("active")
    if (active.nextElementSibling !== null) {
      active.nextElementSibling.classList.add("active")
    } else {
      this.itemTarget.classList.add("active");
    }
  }

  previous() {
    let active = ""
    this.itemTargets.forEach(element => {
      if (element.classList.contains("active")) {
        active = element
      }
    });
    active.classList.remove("active")
    if (active.previousElementSibling !== null) {
      active.previousElementSibling.classList.add("active")
    } else {
      this.itemTargets[this.itemTargets.length - 1].classList.add("active");
    }
  }
}
