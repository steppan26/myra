import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["board"]

  hidden(event) {
    this.boardTargets.forEach((boardTarget) => {
      boardTarget.classList.toggle("d-none");
    })
  }
}
