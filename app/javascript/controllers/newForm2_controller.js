import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectService", "selectOffer", "categoryInput", "serviceIdInput", "priceInput", "frequencyInput", "displayNewOffer",
                    "category", "service", "offerServiceNameInput", "offerPriceInput", "offerFrequencyInput",
                    "customOfferInput", "customService", "customOffer", "formPartOne", "formPartTwo", "renewalInput",
                    "delayInput", "infoInput", "delayFrequencyInput", "serviceIdInput", "offerIdInput", "offerNameInput", "formSubmitButton",
                    "reminderDelayDaysInput", "additionalInfoInput", "reminderDelayDaysInput", "renewalDateInput", "serviceNameInput"]

  connect() {
  };

  showServices(event) {
    const target = event.currentTarget
    const categoryId = target.dataset.categoryId;
    this.categoryInputTarget.value = categoryId;
    this._activate_card(target, this.categoryTargets)
    const query = encodeURIComponent(categoryId);
    fetch(`/searchService/${query}`)
      .then(res => res.text())
      .then(data => {
        this.selectServiceTarget.innerHTML = data;
        target.scrollIntoView();
    })
  };

  showOffers(event) {
    const target = event.currentTarget
    const serviceId = target.dataset.serviceId;
    this.serviceIdInputTarget.value = serviceId;
    this.serviceIdInputTarget.dataset.serviceName = target.dataset.serviceName
    this._activate_card(target, this.serviceTargets)
    const query = encodeURIComponent(serviceId);
    fetch(`/searchOffer/${query}`)
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
      this.offerIdInputTarget.value = -1;
      if (target === this.customServiceTarget) {
        this.selectOfferTarget.innerHTML = "";
        this.displayNewOfferTarget.innerHTML = data;
        const nameInput = this.offerServiceNameInputTarget;
        nameInput.value = "";
        this.offerNameInputTarget.value = 'custom offer'
        nameInput.removeAttribute("disabled");
      } else if (target === this.customOfferTarget) {
        this.displayNewOfferTarget.innerHTML = data;
        const nameInput = this.offerServiceNameInputTarget;
        nameInput.value = this.serviceIdInputTarget.dataset.serviceName;
        nameInput.disabled = true;
        this.offerNameInputTarget.value = 'custom offer'
      } else {
        this.displayNewOfferTarget.innerHTML = data;
        const priceInput = this.offerPriceInputTarget;
        const frequencyInput = this.offerFrequencyInputTarget;
        // set the values of the form with the offer details
        const nameInput = this.offerServiceNameInputTarget;
        nameInput.value = this.serviceIdInputTarget.dataset.serviceName;
        priceInput.value = target.dataset.offerPrice;
        frequencyInput.value = target.dataset.offerFrequency;
        // disable the inputs as values are pre-defined
        nameInput.disabled = true;
        priceInput.disabled = true;
        frequencyInput.disabled = true;
        // insert the values into the hidden form
        this.offerIdInputTarget.value = target.dataset.offerId
        this.priceInputTarget.value = target.dataset.offerPrice
        this.offerNameInputTarget.value = target.dataset.offerName
      }
      this._scroll_to(this.selectOfferTarget)
    })
  };

  offerSelected() {
    const url = "/newOffer";
    fetch(url)
    .then(res => res.text())
    .then(data => {
        this.displayNewOfferTarget.innerHTML = data;
      })
  };

  saveOffer(){
    const nameInput = this.offerNameInputTarget;
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
      //this.serviceNameInputTarget.value = nameInput.value;
      this.priceInputTarget.value = priceInput.value;
      this.frequencyInputTarget.value = frequencyInput.value;
      this.display_sub_overview();
      this.formPartOneTarget.classList.add('hidden');
    }
  }

  display_sub_overview(){
    const name = encodeURIComponent(this.offerNameInputTarget.value);
    const price = encodeURIComponent(this.priceInputTarget.value);
    const frequency = encodeURIComponent(this.frequencyInputTarget.value);
    const category = encodeURIComponent(this.categoryInputTarget.value);
    const service = encodeURIComponent(this.serviceIdInputTarget.value) || -1;
    console.log(name)
    fetch(`/subOverview/?serviceId=${service}&name=${name}&categoryId=${category}&price=${price}&frequency=${frequency}`
    ).then(res => res.text())
     .then(data => {
        this.formPartOneTarget.classList.add('hidden-one');
        this.formPartTwoTarget.innerHTML = data;
        this.formPartTwoTarget.classList.remove('hidden-two');
        this._scroll_to(this.formPartTwoTarget)
     })
  }

  createSubscription() {
    const infoValue = this.infoInputTarget.value;
    const renewalValue = this.renewalInputTarget.value;
    const delayValue = this.delayInputTarget.value;
    const delayFrequencyValue = 'day' //this.delayFrequencyInputTarget.value;
    this.renewalDateInputTarget.value = renewalValue;
    this.additionalInfoInputTarget.value = infoValue;
    this.reminderDelayDaysInputTarget.value = this._get_reminder_in_days(delayValue, delayFrequencyValue);

    if (renewalValue === ""){
      this.renewalInputTarget.classList.add('error')
      return
    } else {
      this.renewalInputTarget.classList.remove('error')
      this._create_new_subscription();
    }
  };

  _get_reminder_in_days(num, type) {
    switch (type.toLowerCase()) {
      case 'month':
        return num * 30
        break;
      case 'week':
        return num * 7
        break;
      case 'day':
        return num
      default:
        return num
    }
  }

  _create_new_subscription() {
    const form = document.getElementById('real-form').children[0];
    form.submit()
  };

  _scroll_to(target) {
    const top = target.offsetTop + 200
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
