import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['mail', 'mailform', 'budget', 'budgetform', 'mailcard', 'budgetcard'];

  displayForm() {
    this.mailTarget.classList.add('d-none');
    this.mailformTarget.classList.remove('d-none');
  }

  displayForm2() {
    this.budgetTarget.classList.add('d-none');
    this.budgetformTarget.classList.remove('d-none');
  }

  update(event) {
    event.preventDefault();
    const url = this.mailformTarget.action
    fetch(url, {
      method: 'PATCH',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(this.mailformTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.mailcardTarget.outerHTML = data;
      })
  }

  update2(event) {
    event.preventDefault();
    const url = this.budgetformTarget.action
    fetch(url, {
      method: 'PATCH',
      headers: { 'Accept': 'text/plain' },
      body: new FormData(this.budgetformTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.budgetcardTarget.outerHTML = data;
      })
  }
}
