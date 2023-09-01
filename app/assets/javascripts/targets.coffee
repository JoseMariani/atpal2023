$ ->

  $('#target_index_table').dataTable()

  for modal in $("div[id*=new_target_modal]")
    do ->
      $(modal).on "show.bs.modal", ->
        timeField = $(this).find('.datepicker')
        $.evaluation.target.activate_date_picker(timeField)
      $(modal).on "hidden.bs.modal", ->
        $.evaluation.target.reset_modal($(this))
      $.evaluation.target.form_validator(modal)

  for modal in $("div[id*=edit_target_modal]")
    do ->
      $(modal).on "show.bs.modal", ->
        timeField = $(this).find('.datepicker')
        $.evaluation.target.activate_date_picker(timeField)

        $(this).find('#update_target').on 'click', (event)->
          $(this).parent().parent().find('#edit_target_form').submit()

      $('body').delegate '#'+$(modal).attr('id'), "shown.bs.modal", (event) ->
        $.evaluation.target.form_validator($(this))


