import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["button"]

  hidden(event) {
    this.buttonTargets.forEach((buttonTarget) => {
      buttonTarget.classList.toggle("d-none");
    })
  }
}
