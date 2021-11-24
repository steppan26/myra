import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["service", "category", "autocomplete"]
  connect() {
    this.serviceTarget.insertAdjacentHTML('afterend', `<div id="autocomplete-box" data-newForm-target='autocomplete'></div>`)
  }

  selectCategory(e) {
    console.log(this.autocompleteTarget)
    const query = this.categoryTarget.value
    const url = `http://localhost:3000/test/${query}`
    fetch(url)
      .then(res => res.text())
      .then(data => {

      })
  }

}
