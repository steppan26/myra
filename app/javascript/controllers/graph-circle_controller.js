import { Controller } from "stimulus";
import ProgressBar from "progressbar.js";

export default class extends Controller {
  static targets = ["circle"]
  static values = {
    budget: Number,
    amount: Number
  }

  connect() {
    const progressCircle = this.circleTarget;
    const budget = this.budgetValue;
    const amount = this.amountValue;
    const percent = (amount / budget) * 100 ;

    const bar = new ProgressBar.Circle(progressCircle, {
      color: '#6743B8',
      strokeWidth: 6,
      trailColor: '#322247',
      trailWidth: 6,
      easing: 'easeInOut',
      duration: 3000,
      strokeColor: '#6743B8',
      svgStyle: null,
      text: {
        value: '',
        alignToBottom: false,
        style: {
          fontSize: '15px',
          position: 'absolute',
          left: '50%',
          top: '50%',
          padding: 0,
          margin: 0,
          transform: {
            prefix: true,
            value: 'translate(-50%, 50%)'
          }
        },
      },
      step: (state, bar) => {
        const text = `
          <p><b>${amount}</b>€/month</p>
        `;
        bar.setText(text);
        bar.text.style.color = "white";
      }
    });

    bar.animate(percent / 100);  // Number from 0.0 to 1.0
  }

  disconnect() {
    this.circleTarget.innerHTML = "";
  }
}
