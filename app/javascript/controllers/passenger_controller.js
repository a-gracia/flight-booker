import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { count: Number };
  static targets = ["tbody", "passengerrow"];
  initialize() {
    for (let i = 1; i < this.countValue; i++) {
      this.appendPassenger(i);
    }
  }

  addPassenger() {
    this.countValue++;
  }

  countValueChanged() {
    this.appendPassenger(this.countValue);
  }

  appendPassenger(index) {
    // Get DOM elements
    const tbody = this.tbodyTarget;
    const template = this.passengerrowTarget;

    // Clone template
    let clone = document.importNode(template.content, true);

    clone.querySelector("tr").setAttribute("passenger_id", index);

    // Get clone elements
    let td = clone.querySelectorAll("td");
    let reducedTd = [td[0], td[1]];
    reducedTd.forEach((element) => {
      // Set label attributes
      let label = element.querySelector("label");
      let labelFor = label.getAttribute("for");
      label.setAttribute("for", labelFor.replace("INDEX", index));

      // Set input attributes
      let input = element.querySelector("input");
      let inputName = input.getAttribute("name");
      input.setAttribute("name", inputName.replace("INDEX", index));

      let inputId = input.getAttribute("id");
      input.setAttribute("id", inputId.replace("INDEX", index));
    });

    // update button
    let button = td[2].querySelector("button");
    button.setAttribute("passenger_id", index);

    // Append to form
    tbody.appendChild(clone);
  }

  removePassenger(event) {
    event.preventDefault();
    let passengerCount = this.tbodyTarget.querySelectorAll("tr").length;

    if (passengerCount > 1) {
      let passenger_id = event.currentTarget.getAttribute("passenger_id");

      let queryString = 'tr[passenger_id="' + passenger_id + '"]';
      let tr = this.tbodyTarget.querySelector(queryString);

      tr.remove();
    }
  }
}
