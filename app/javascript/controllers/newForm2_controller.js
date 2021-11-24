import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectService", "selectOffer"]
  connect() {
  };

  showServices(event) {
    const category = event.currentTarget.children[0].innerText;
    let query = encodeURIComponent(category);
    const url = `/searchService/${query}`;
    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.selectServiceTarget.innerHTML = data;
    })
  };

  showOffers(event) {
    const service = event.currentTarget.innerText;
    const query = encodeURIComponent(service);
    const url = `/searchOffer/${query}`;

    fetch(url)
      .then(res => res.text())
      .then(data => {
        this.selectOfferTarget.innerHTML = data;
        // scroll window up
        const target = this.selectServiceTarget;
        this._scroll_to(target);
        // display the offers OR inputs
      })
  };

  createNewOffer() {
    console.log("custom offer incoming...");
  };

  _scroll_to(target) {
    const top = target.offsetHeight + 80
    console.log(target);
    window.scrollTo({
      top: top,
      left: 0,
      behavior: 'smooth'
    });
  }
}
