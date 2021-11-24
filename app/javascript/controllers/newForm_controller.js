import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["service", "category", "autocomplete"]
  connect() {
    this.serviceTarget.insertAdjacentHTML('afterend', `<div id="autocomplete-services" data-newForm-target='autocomplete'></div>`)
  }

  showServices(e) {
    console.log('focused')
    const category = this.categoryTarget.value
    if (category) {
      const query = encodeURIComponent(category)
      const url = `http://localhost:3000/search/${query}`;
      fetch(url)
        .then(res => res.text())
        .then(data => {
          this.autocompleteTarget.classList.remove('hidden');
          this.autocompleteTarget.innerHTML = data;
        })
    }
  }

  hideServices() {
    this.autocompleteTarget.classList.add('hidden');
  }

  selectService(event){
    this.serviceTarget.value = event.currentTarget.children[0].innerText
  }

}
