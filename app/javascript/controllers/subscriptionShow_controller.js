import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["show", "edit", "renewalInput", "renewalElement", "addInfoInput", "addInfoElement", "delayInput", "delayElement"]


  connect(){
  }

  display_edit(){
    this.showTargets.forEach((element) => {
      element.classList.add('hidden');
    })
    this.editTargets.forEach((element) => {
      element.classList.remove('hidden');
    })
  }

  display_show(){
    this.showTargets.forEach((element) => {
      element.classList.remove('hidden');
    })
    this.editTargets.forEach((element) => {
      element.classList.add('hidden');
    })
  }

  save_changes(){
    const renewalDateValue = this.renewalInputTarget.value
    const addInfoValue = this.addInfoInputTarget.value
    const delayValue = this.delayInputTarget.value
  }

  discard_changes(){
    this.renewalInputTarget.value = this.renewalElementTarget.innerText;
    this.addInfoInputTarget.value = this.addInfoElementTarget.innerText;
    this.delayInputTarget.value = this.delayElementTarget.innerText;
    this.display_show();
  }
}
