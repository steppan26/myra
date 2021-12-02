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
    let amount = this.amountValue;
    const color = (amount > budget) ? '#FD1215' : '#6743B8';
    const amountEuro = new Intl.NumberFormat('de-DE', { style: 'currency', currency: 'EUR' }).format(amount);
    amount = (amount > budget) ? budget : amount;
    const percent = (amount / budget) * 100 ;
    const bar = new ProgressBar.Circle(progressCircle, {
      color: color,
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
            value: 'translate(-40%, -50%)'
          }
        },
      },
      step: (state, bar) => {
        const text = `
          <p><b>${amountEuro}</b><br><i>/month</i></p>
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
