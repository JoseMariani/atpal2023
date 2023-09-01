$ ->

  $.evaluation.quiz.set_date_picker_plugin($('#quiz-form'))

  $.evaluation.quiz.quiz_letter_grade_calculator($('#quiz-form'))

  $.evaluation.quiz.form_validator($('#quiz-form'))

  $("#new_quiz_modal").on "hidden.bs.modal", ->
    $.evaluation.quiz.clear_modal($("#new_quiz_modal"))

  $('#quiz_index_table').dataTable()

  $("#edit_quiz_modal").on "show.bs.modal", ->
    $.evaluation.quiz.set_date_picker_plugin($('#quiz-edit-form'))

    $.evaluation.quiz.quiz_letter_grade_calculator($('#quiz-edit-form'))

    $.evaluation.quiz.form_validator($('#quiz-edit-form'))

    $('#edit-quiz-submit').on 'click', ->
      $('#quiz-edit-form').submit()




