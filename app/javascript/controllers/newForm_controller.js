import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("yoohoo")
  }

  selectCategory(e) {
    console.log(e.currentTarget.value)
  }

}
