import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["subscriptions"]

  display_edit(event) {
    console.log('click')
  }

  toggle_sub(event){
    const selected_sub = event.currentTarget.children[0]
    this.subscriptionsTargets.forEach(subscription => {
      if (subscription.value === selected_sub.dataset.subValue) {
        subscription.checked = !subscription.checked;
        selected_sub.classList.toggle('selected');
      }
    });
  }
}
