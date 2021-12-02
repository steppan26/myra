import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["subscriptions", "budgetSubs", "userSubs", "removeSubBtn", "editForm", "showPage", "deleteBtn", "newNameInput", "newPriceInput"]
  static values = { budgetId: Number }

  display_edit() {
    this.showPageTarget.classList.toggle('hidden');
    this.editFormTarget.classList.toggle('hidden');
    this.removeSubBtnTargets.forEach(button => {
      button.classList.toggle('hidden');
    })
    this.deleteBtnTarget.classList.toggle('hidden');
  }

  save_changes(){
    if (this.newNameInputTarget.value === '' || this.newPriceInputTarget.value === '' || !/^\d+(?:(\.)?\d{0,2})$/.test(this.newPriceInputTarget.value)) {
      console.log('invalid input')
      this.display_edit()
      this.newNameInputTarget.value = this.element.dataset.budget_name
      this.newPriceInputTarget.value = this.element.dataset.budget_price
    } else {
      const budgetId = this.element.dataset.budget_id
      const new_price = this.newPriceInputTarget.value
      const new_name = this.newNameInputTarget.value
      console.log(new_name, new_price)
      fetch(`/updateBudgetsInfo/${budgetId}?name=${new_name}&price=${new_price}`)
        .then(() => {
          this.display_edit()
          this.newNameInputTarget.value = this.element.dataset.budget_name
          this.newPriceInputTarget.value = this.element.dataset.budget_price
        })
    }
  }

  toggle_sub(event){
    const selected_sub = event.currentTarget.children[0];
    this.subscriptionsTargets.forEach(subscription => {
      if (subscription.value === selected_sub.dataset.subValue) {
        selected_sub.classList.toggle('selected');
        if (selected_sub.classList.contains('selected')) {
          subscription.checked = true;
        } else {
          subscription.checked = false;
        }
      }
    });
  }

  display_new_subs_to_add() {
    this.budgetSubsTarget.classList.add('hidden')
    this.userSubsTarget.classList.remove('hidden')
  };

  add_subs() {
    const selectedIds = this.subscriptionsTargets.filter(sub => sub.checked).map(sub => sub.value).join()
    const url = `/updateBudgets/${this.element.dataset.budget_id}?selectedSubs=${selectedIds}`
    fetch(url)
  };
}
