import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["serviceInput", "categoryInput", "autocompleteServices", "autocompleteOffers", "serviceCustom",
                    "servicePreset", "service", "offer", "offerCustom", "offerPreset", "priceInput", "frequencyInput"]
  connect() {
    this.categoryInputTarget.insertAdjacentHTML('afterend', `
        <div class="autocomplete-wrapper" id="autocomplete-services" data-newForm-target='autocompleteServices'></div>
        <div class="autocomplete-wrapper" id="autocomplete-offers" data-newForm-target='autocompleteOffers'></div>
        `);
  };

  showServices() {
    this.autocompleteServicesTarget.classList.remove('hidden');
    const category = this.categoryInputTarget.value;
    if (category) {
      const query = encodeURIComponent(category);
      const url = `/searchService/${query}`;
      fetch(url)
        .then(res => res.text())
        .then(data => {
          this.autocompleteServicesTarget.innerHTML = data;
        })
    }
  };

  _hideServices() {
    this.autocompleteServicesTarget.classList.add('hidden');
  };

  showOffers(){
    this.autocompleteOffersTarget.classList.remove('hidden');
    const query = encodeURIComponent(this.serviceInputTarget.value);
    const url = `/searchOffer/${query}`;
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.autocompleteOffersTarget.innerHTML = data;
      });
  };

  _hideOffers() {
    this.autocompleteOffersTarget.classList.add('hidden');
  };

  selectService(event){
    const services = this.serviceTargets;
    services.forEach(service => {
      if (service === event.currentTarget) {
        service.classList.add('active');
      } else {
        service.classList.remove('active');
      }
    });
    if (event.currentTarget === this.serviceCustomTarget){
      this.serviceInputTarget.value = "";
      this.serviceInputTarget.parentElement.classList.remove('hidden');
      this._hideOffers();
    } else {
      this.serviceInputTarget.parentElement.classList.add('hidden');
      this.serviceInputTarget.value = event.currentTarget.children[0].innerText;
      this.showOffers();
    }
  };

  selectOffer(event) {
    const offers = this.offerTargets;
    offers.forEach(offer => {
      if (offer === event.currentTarget) {
        offer.classList.add('active');
      } else {
        offer.classList.remove('active');
      }
    });
    const price = this.priceInputTarget;
    const frequency = this.frequencyInputTarget;
    console.log(event.currentTarget);
    if (event.currentTarget === this.offerCustomTarget) {
      price.parentElement.classList.remove('hidden');
      frequency.parentElement.classList.remove('hidden');
      price.value = "";
      frequency.value = "";

      console.log(price, frequency);
    } else {
      price.parentElement.classList.add('hidden');
      price.value = event.currentTarget.dataset.offerPrice
      frequency.parentElement.classList.add('hidden');
      frequency.value = event.currentTarget.dataset.offerFrequency
      console.log(price, frequency);
    };
  };
}
