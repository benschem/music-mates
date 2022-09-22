import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert';

// Connects to data-controller="sweet-alert"
export default class extends Controller {
  static values = {
    title: String,
    text: String,
    icon: String,
    buttons: Boolean,
  }

  fireModal() {
    swal({
      title: this.titleValue,
      text: this.textValue,
      icon: this.iconValue,
      buttons: this.buttonValue
    });
  }
}
