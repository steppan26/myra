import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectService", "selectOffer", "categoryInput", "serviceInput", "priceInput", "frequencyInput", "displayNewOffer",
                    "category", "service", "offerServiceNameInput", "offerPriceInput", "offerFrequencyInput",
                    "customOfferInput", "customService", "customOffer"]

  connect() {
  };

  showServices(event) {
    const category = event.currentTarget.children[0].innerText;
    this.categoryInputTarget.value = category;
    this._activate_card(event.currentTarget, this.categoryTargets)
    let query = encodeURIComponent(category);
    const url = `/searchService/${query}`;
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.selectServiceTarget.innerHTML = data;
    })
  };

  showOffers(event) {
    const service = event.currentTarget.innerText;
    this.serviceInputTarget.value = service;
    this._activate_card(event.currentTarget, this.serviceTargets)
    const query = encodeURIComponent(service);
    const url = `/searchOffer/${query}`;
    fetch(url)
      .then(res => res.text())
      .then(data => {
        // display the offers OR inputs
        this.displayNewOfferTarget.innerHTML = "";
        this.selectOfferTarget.innerHTML = data;
        // scroll window up
        const target = this.selectServiceTarget;
        this._scroll_to(target);
      })
  };

  createNewOffer(event) {
    const target = event.currentTarget;
    this._activate_card(target, this.serviceTargets)
    const url = "/newOffer";
    fetch(url)
    .then(res => res.text())
    .then(data => {
      if (target === this.customServiceTarget) {
        this.selectOfferTarget.innerHTML = "";
        this.displayNewOfferTarget.innerHTML = data;
        const nameInput = this.offerServiceNameInputTarget;
        nameInput.value = "";
        nameInput.removeAttribute("disabled");
      } else if (target === this.customOfferTarget) {
        this.displayNewOfferTarget.innerHTML = data;
        const nameInput = this.offerServiceNameInputTarget;
        nameInput.value = this.serviceInputTarget.value;
        nameInput.disabled = true;
      } else {
        this.displayNewOfferTarget.innerHTML = data;
        const nameInput = this.offerServiceNameInputTarget;
        const priceInput = this.offerPriceInputTarget;
        const frequencyInput = this.offerFrequencyInputTarget;
        nameInput.value = this.serviceInputTarget.value;
        priceInput.value = target.dataset.offerPrice;
        frequencyInput.value = target.dataset.offerFrequency;
        nameInput.disabled = true;
        priceInput.disabled = true;
        frequencyInput.disabled = true;
      }
      this._scroll_to(this.selectOfferTarget)
    })
  };

  offerSelected(event) {
    const url = "/newOffer";
    fetch(url)
    .then(res => res.text())
    .then(data => {
        this.displayNewOfferTarget.innerHTML = data;
      })
  };

  saveOffer(){
    const nameInput = this.offerServiceNameInputTarget;
    const priceInput = this.offerPriceInputTarget;
    const frequencyInput = this.offerFrequencyInputTarget;
    const nameError = document.getElementById('name-error');
    const priceError = document.getElementById('price-error');

    nameError.classList.add('hidden');
    priceError.classList.add('hidden');

    if (nameInput.value === "" && priceInput.value === "") {
      nameError.classList.remove('hidden');
      priceError.classList.remove('hidden');
    } else if (nameInput.value === "") {
      nameError.classList.remove('hidden');
    } else if (priceInput.value === "") {
      priceError.classList.remove('hidden');
    } else {
      this.serviceInputTarget.value = nameInput.value;
      this.priceInputTarget.value = priceInput.value;
      this.frequencyInputTarget.value = frequencyInput.value;

    }
  }

  _scroll_to(target) {
    const top = target.offsetHeight + 80
    window.scrollTo({
      top: top,
      left: 0,
      behavior: 'smooth'
    });
  }

  _activate_card(target, items_array) {
    items_array.forEach(item => {
      if (item === target) {
        item.classList.add('active');
        item.classList.remove('inactive');
      } else {
        item.classList.add('inactive');
        item.classList.remove('active');
      }
    });
  }
}
