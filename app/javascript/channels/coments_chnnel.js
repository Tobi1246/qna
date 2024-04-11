import consumer from "./consumer"
$(document).on('turbolinks:load', () => {
  consumer.subscriptions.create("ComentsChannel", {
    connected() {
      this.perform('follow')
    },

    received(data) {
      if (data.comentable == answer) {
        $('.coment_answer').append(data.coment)
      }
      if (data.comentable == question) {
        $('.coment_question').append(data.coment)
      }
    }
  });

})
