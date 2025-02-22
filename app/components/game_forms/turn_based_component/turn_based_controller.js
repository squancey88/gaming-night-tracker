import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ['turnGrid', 'turnCounter', 'emptyPlayerRow']

  connect() {
  }

  addTurn() {
    const turnNumber = this.turnCounterTargets.length + 1;
    const template = this.emptyPlayerRowTarget;
    const content = template.innerHTML.replace(/TURN_NUMBER/g, turnNumber);
    this.turnGridTarget.insertAdjacentHTML('beforeend', content);
  }

}
