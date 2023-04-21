import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="admin"
export default class extends Controller {
  connect() {
    $('.admin-activated-checkbox').change(()=> {
      $('#admin-save-button').prop('disabled', false)
    })
  }
}
