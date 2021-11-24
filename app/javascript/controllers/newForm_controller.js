import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["serviceInput", "categoryInput", "autocompleteServices", "serviceCustom", "servicePreset", "service"]
  connect() {
    this.categoryInputTarget.insertAdjacentHTML('afterend', `
        <div id="autocomplete-services" data-newForm-target='autocompleteServices'></div>
        <div id="autocomplete-offers" data-newForm-target='autocompleteOffers'></div>
        `);
  }

  showServices() {
    this.autocompleteServicesTarget.classList.remove('hidden');
    const category = this.categoryInputTarget.value;
    if (category) {
      const query = encodeURIComponent(category);
      const url = `http://localhost:3000/searchService/${query}`;
      fetch(url)
        .then(res => res.text())
        .then(data => {
          this.autocompleteServicesTarget.innerHTML = data;
        })
    }
  }

  showOffers(){
    const autocompleteOffers = document.querySelector('#autocomplete-offers');
    console.log(this.serviceInputTarget.value);
    const query = encodeURIComponent(this.serviceInputTarget.value);
    const url = `http://localhost:3000/searchOffer/${query}`;
    fetch(url)
      .then(res => res.text())
      .then(data => {
        autocompleteOffers.innerHTML = data;
      });
  }

  hideServices() {
    setInterval(() => {
      this.autocompleteServicesTarget.classList.add('hidden');
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
      this.showOffers();
    }
  }

}
