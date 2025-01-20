$(function () {
  $('[data-clear]').on('click', function () {
    const questionId = $(this).data('clear').replace('clear-question-', '');
    $(`input[name="test[${questionId}][answer_id]"]`).prop('checked', false);
  });
});
