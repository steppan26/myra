import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectService", "selectOffer", "categoryInput", "serviceInput", "displayNewOffer",
                    "category", "service", "offerServiceNameInput", "offerPriceInput", "offerFrequencyInput",
                    "customOfferInput"]

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
        this.selectOfferTarget.innerHTML = data;
        // scroll window up
        const target = this.selectServiceTarget;
        this._scroll_to(target);
      })
  };

  createNewOffer(event) {
    this._activate_card(event.currentTarget, this.serviceTargets)
    const url = "/newOffer";
    fetch(url)
    .then(res => res.text())
    .then(data => {
        this.displayNewOfferTarget.innerHTML = data;
        const nameInput = this.offerServiceNameInputTarget;
        nameInput.value = this.serviceInputTarget.value;

        this._scroll_to(this.selectOfferTarget)
      })

  };

  saveOffer(){
    const nameInput = this.offerServiceNameInputTarget;
    const priceInput = this.offerPriceInputTarget;
    const frequencyInput = this.offerFrequencyInputTarget;
    const customOfferInputs = this.customOfferInputTargets;

    console.log(customOfferInputs)
  }

  _scroll_to(target) {
    const top = target.offsetHeight + 80
    console.log(target);
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
