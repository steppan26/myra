import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["subscriptions", "nameInput", "priceInput", "errorMessage", "formWrapper"]

  connect(){
  }

  toggleSub(event){
    const selected_sub = event.currentTarget.children[0]
    this.subscriptionsTargets.forEach(subscription => {
      if (subscription.value === selected_sub.dataset.subValue) {
        subscription.checked =! subscription.checked;
        selected_sub.classList.toggle('selected');
      }
    });
  };

  create_budget() {
    if (this.nameInputTarget.value === "" || this.priceInputTarget.value === "") {
      this.errorMessageTarget.classList.remove('hidden')
      console.log('removing class')
    } else {
      const form = this.formWrapperTarget.querySelector('form')
      this.errorMessageTarget.classList.add('hidden')
      form.submit()
    }
  };
}
