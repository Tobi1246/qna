import consumer from "./consumer"

$(document).on('turbolinks:load', () => {
  consumer.subscriptions.create('QuestionsChannel', {
    connected() {
      this.perform('follow')
    },

    received(data) {
      $('.questions_list').append(data.question)
    }
  })
})
