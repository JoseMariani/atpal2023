$ ->

#events

  for modal in $("div[id*=new_automatization_modal]")
    do ->
      $(modal).on "show.bs.modal", ->
        timeField = $(this).find('.datepicker')
        $.evaluation.automatization.activate_date_picker(timeField)
      $(modal).on "hidden.bs.modal", ->
        $.evaluation.automatization.reset_modal($(this))
      $.evaluation.automatization.form_validator(modal)

  for modal in $("div[id*=edit_automatization_modal]")
    do ->
      $(modal).on "show.bs.modal", ->
        timeField = $(this).find('.datepicker')
        $.evaluation.automatization.activate_date_picker(timeField)

        $(this).find('#edit-automatization').on 'click', (event)->
          $(this).parent().parent().find('#edit-automatization-form').submit()

      $('body').delegate '#'+$(modal).attr('id'), "shown.bs.modal", (event) ->
        $.evaluation.automatization.form_validator($(this))

  $('#auto_index_table').dataTable()