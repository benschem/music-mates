import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )

    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`)
  }
  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }
  // # = JS's private
  #insertMessageAndScrollDown(data) {
    // put it in the final div
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    // scroll to bottom
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }
  resetForm(event) {
    event.target.reset()
  }
}
