import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["subscriptions"]

  connect(){
    console.log('hello from subscriptions list controller');
  }

  toggleSub(event){
    const selected_sub = event.currentTarget.children[0]
    this.subscriptionsTargets.forEach(subscription => {
      if (subscription.value === selected_sub.dataset.subValue) {
        subscription.checked =! subscription.checked;
        selected_sub.classList.toggle('selected');
      }
    });
  }
}
