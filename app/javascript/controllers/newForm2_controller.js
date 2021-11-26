import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectService", "selectOffer", "categoryInput", "serviceInput", "priceInput", "frequencyInput", "displayNewOffer",
                    "category", "service", "offerServiceNameInput", "offerPriceInput", "offerFrequencyInput",
                    "customOfferInput", "customService", "customOffer", "formPartOne", "formPartTwo", "renewalInput",
                    "delayInput", "infoInput", "delayFrequencyInput"]

  connect() {
  };

  showServices(event) {
    const target = event.currentTarget
    const category = target.children[0].innerText;
    this.categoryInputTarget.value = category;
    this._activate_card(target, this.categoryTargets)
    let query = encodeURIComponent(category);
    const url = `/searchService/${query}`;
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.selectServiceTarget.innerHTML = data;
        target.scrollIntoView();
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
      this.display_sub_overview();
      this.formPartOneTarget.classList.add('hidden');
    }
  }

  display_sub_overview(){
    const name = encodeURIComponent(this.serviceInputTarget.value);
    const price = encodeURIComponent(this.priceInputTarget.value);
    const frequency = encodeURIComponent(this.frequencyInputTarget.value);
    const category = encodeURIComponent(this.categoryInputTarget.value);

    const formData = {category, name, price, frequency }
    fetch(`/subOverview/?name=${name}&category=${category}&price=${price}&frequency=${frequency}`
    ).then(res => res.text())
     .then(data => {
        this.formPartOneTarget.classList.add('hidden-one');
        this.formPartTwoTarget.innerHTML = data;
        this.formPartTwoTarget.classList.remove('hidden-two');
        this._scroll_to(this.formPartTwoTarget)
     })
  }

  createSubscription() {
    const form = document.getElementById('real-form');
    const infoValue = this.infoInputTarget.value
    const renewalValue = this.renewalInputTarget.value
    const delayValue = this.delayInputTarget.value
    const delayFrequencyValue = this.delayFrequencyInputTarget.value
    if (renewalValue === ""){
      this.renewalInputTarget.classList.add('error')
      return
    } else {
      this.renewalInputTarget.classList.remove('error')
      console.log(document.getElementById('real-form'))
      const data = {
        subscription: {
          renewal_date: renewalValue,
          price: this.priceInputTarget.value,
          reminder_delay_days: renewalValue,
        },
        offer: {
          name: this.serviceInputTarget.value,
          frequency: this.frequencyInputTarget.value,
          category: this.categoryInputTarget.value,
          price: this.priceInputTarget.value
        }
      }
      this._create_new_subscription(data)
    }
  };

  _get_reminder_in_days() {
    return this.delayInputTarget.value;
  }

  _create_new_subscription(data) {
    console.log(data);
    fetch("/subscriptions", {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    })
  };

  _scroll_to(target) {
    const top = target.offsetTop + 200
    console.log(target, top)
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
