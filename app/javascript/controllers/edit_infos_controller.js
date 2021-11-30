import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['mail', 'mail_form', 'budget', 'budget_form'];

  displayForm() {
    this.infosTarget.classList.add('d-none');
    this.formTarget.classList.remove('d-none');
  }
}
