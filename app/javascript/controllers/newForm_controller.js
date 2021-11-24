import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["serviceInput", "categoryInput", "autocomplete", "serviceCustom", "servicePreset", "service"]
  connect() {
    this.categoryInputTarget.insertAdjacentHTML('afterend', `<div id="autocomplete-services" data-newForm-target='autocomplete'></div>`)
  }

  showServices(e) {
    this.autocompleteTarget.classList.remove('hidden');
    const category = this.categoryInputTarget.value;
    if (category) {
      const query = encodeURIComponent(category);
      const url = `http://localhost:3000/search/${query}`;
      fetch(url)
        .then(res => res.text())
        .then(data => {
          this.autocompleteTarget.innerHTML = data;
        })
    }
  }

  hideServices() {
    setInterval(() => {
      this.autocompleteTarget.classList.add('hidden');
    }, 2000);
  }

  selectService(event){
    const services = this.serviceTargets;
    services.forEach(service => {
      if (service === event.currentTarget) {
        service.classList.add('active');
      } else {
        service.classList.remove('active');
      }
    });
    console.log(this.serviceInputTarget.parentElement);
    if (event.currentTarget === this.serviceCustomTarget){
      this.serviceInputTarget.value = "";
      this.serviceInputTarget.parentElement.classList.remove('hidden');
    } else {
      this.serviceInputTarget.parentElement.classList.add('hidden');
      this.serviceInputTarget.value = event.currentTarget.children[0].innerText;
    }
  }

}
