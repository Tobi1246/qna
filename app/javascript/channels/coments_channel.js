import consumer from "./consumer"

$(document).on('turbolinks:load', () => {
  consumer.subscriptions.create("ComentsChannel", {
    connected() {
      this.perform('follow', { question_id: $('.question').attr('id') })
    },

    received(data) {
      console.log(data.comentable)
        $('.coment_' + data.comentable).append(data.coment)
    }
  });

})
