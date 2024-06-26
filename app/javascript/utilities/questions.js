$(document).on('turbolinks:load',function(){
  $('.edit-question-link').on('click', function(e) {
    e.preventDefault()
    $(this).hide();
    let questionId = $(this).data('questionId');
    $('form#edit-question-' + questionId).show('');
  })
});

$(document).on('turbolinks:load',function(){
  $('.create-question-link').on('click', function(e) {
    e.preventDefault()
    $(this).hide();
    $('body > form').show('');
  })
});

$(document).on('turbolinks:load',function(){
  $('.question .votes_question').on('ajax:success', function(e) {
    let questionVotePoint = e.detail[0];
    $('.votes_question .vote_result').html(questionVotePoint);
    $('.question .delete_vote > form > input').show('');
  })
    .on('ajax:error', function(e) {
      let errors = e.detail[0];
      $.each(errors, function(index, value){
        $('.question-errors').html('<p>' + value + '<p>');
      })
    })

  $('.question .delete_vote').on('ajax:success', function(e) {
    let questionVotePoint = e.detail[0];
    $('.question .votes_question .vote_result').html(questionVotePoint + '<p>' + 'Ur vote delete' + '<p>');
    $('.question .delete_vote > form > input').hide('');
  })
    .on('ajax:error', function(e) {
      let errors = e.detail[0];
      $.each(errors, function(index, value){
        $('.question-errors').replaceWith('<p>' + value + '<p>');
      })
    })
});

$(document).on('turbolinks:load',function(){
  $('.question .form').on('ajax:success', function(e) {
    let coment = e.detail[0];
    $('.coment_question').html(coment.body);
    console.log(coment.body)
  })
    .on('ajax:error', function(e) {
      let errors = e.detail[0];
      $.each(errors, function(index, value){
        $('.question-errors').html('<p>' + value + '<p>');
      })
    })
});