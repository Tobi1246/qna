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
    $('.answers .answer .votes_answer .vote_result').replaceWith(answerVotePoint);
    $('.answer .delete_vote > form > input').show('');  
  })
    .on('ajax:error', function(e) {
      let errors = e.detail[0];
      $.each(errors, function(index, value){
        $('.answer-errors').replaceWith('<p>' + value + '<p>');
      })
    })


});

$(document).on('turbolinks:load',function(){
  $('.answer .delete_vote').on('ajax:success', function(e) {
    let answerVotePoint = e.detail[0];
    $('.answers .answer .votes_answer .vote_result').replaceWith(answerVotePoint + '<p>' + 'Ur vote delete' + '<p>');
    $('.answer .delete_vote > form > input').hide('');
  })
    .on('ajax:error', function(e) {
      let errors = e.detail[0];
      $.each(errors, function(index, value){
        $('.answer-errors').replaceWith('<p>' + value + '<p>');
      })
    })  
});
