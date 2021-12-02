import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["subscriptions", "budgetSubs", "userSubs"]

  display_edit(event) {
    console.log('click')
  }

  toggle_sub(event){
    console.log('ruihgeoigh')
    const selected_sub = event.currentTarget.children[0]
    this.subscriptionsTargets.forEach(subscription => {
      if (subscription.value === selected_sub.dataset.subValue) {
        subscription.checked = !subscription.checked;
        selected_sub.classList.toggle('selected');
      }
    });
  }

  display_new_subs_to_add() {
    this.budgetSubsTarget.classList.add('hidden')
    this.userSubsTarget.classList.remove('hidden')
  };

  add_subs() {

  };
}
