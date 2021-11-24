import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["service", "category", "autocomplete"]
  connect() {
    this.serviceTarget.insertAdjacentHTML('afterend', `<div id="autocomplete-box" data-newForm-target='autocomplete'></div>`)
  }

  selectCategory(e) {
    console.log(this.autocompleteTarget)
    let query = this.categoryTarget.value
    query = 'hahn'
    const url = `http://localhost:3000/search/${query}`;
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.autocompleteTarget.innerHTML = data;
      })
  }

}
