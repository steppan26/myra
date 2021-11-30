import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["show", "edit", "renewalInput", "renewalElement", "addInfoInput", "addInfoElement",
                    "delayInput", "delayElement", "formRenewalDate", "formAddInfo", "formDaysDelay"]


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
    this.formRenewalDateTarget.value = this.renewalInputTarget.value
    this.formAddInfoTarget.value = this.addInfoInputTarget.value
    this.formDaysDelayTarget.value = this.delayInputTarget.value
    document.getElementById('form-wrapper').children[0].submit()
  }

  discard_changes(){
    this.renewalInputTarget.value = this.renewalElementTarget.innerText;
    this.addInfoInputTarget.value = this.addInfoElementTarget.innerText;
    this.delayInputTarget.value = this.delayElementTarget.innerText;
    this.display_show();
  }
}
