$(document).on('turbolinks:load',function(){
  
  $('.edit-answer-link').on('click', function(e) {
    e.preventDefault()
    $(this).hide();
    let answerId = $(this).data('answerId');
    $('form#edit-answer-' + answerId).show('');
  })
});

$(document).on('turbolinks:load',function(){
  $('.answer .votes_answer').on('ajax:success', function(e) {
    let answerVotePoint = e.detail[0];
    $('div.votes_answer > div').replaceWith(answerVotePoint);
    $('div.delete_vote > form > input[type=submit]:nth-child(2)').show('');  
  })
    .on('ajax:error', function(e) {
      console.log(e)
      let errors = e.detail[0];
      $.each(errors, function(index, value){
        $('.answer-errors').replaceWith('<p>' + value + '<p>');
      })
    })

  $('.answer .delete_vote').on('ajax:success', function(e) {
    let answerVotePoint = e.detail[0];
    $('div.votes_answer > div').replaceWith(answerVotePoint + '<p>' + 'Ur vote delete' + '<p>');
    $('div.delete_vote > form > input[type=submit]:nth-child(2)').hide('');
  })
    .on('ajax:error', function(e) {
      console.log(e)
      let errors = e.detail[0];
      $.each(errors, function(index, value){
        $('.answer-errors').replaceWith('<p>' + value + '<p>');
      })
    })
});
