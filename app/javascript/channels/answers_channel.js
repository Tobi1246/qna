import consumer from "./consumer"

$(document).on('turbolinks:load', () => {
  consumer.subscriptions.create('AnswersChannel', {
    connected() {
      this.perform('follow', { question_id: $('.question').attr('id') })
    },

    received(data) {
      if (gon.user_id != data.answer_author_id) {
        $('.answers').append(data.answer)

        if (gon.user_id == data.question_author_id) {
          $(`#answer-${data.answer_id} .best-link`).show()
        }

        if (gon.user_id) {
          $(`#answer-${data.answer_id} .vote-link`).show()
        }
      }
    }
  })
})
