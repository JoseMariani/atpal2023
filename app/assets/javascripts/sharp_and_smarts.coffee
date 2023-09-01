$ ->

  for modal in $("div[id*=new_sharp_and_smart_modal]")
    do ->
      $(modal).on "show.bs.modal", ->
        timeField = $(this).find('.datepicker')
        $.evaluation.target.activate_date_picker(timeField)
      $(modal).on "hidden.bs.modal", ->
        $.evaluation.sns.reset_modal($(this))
      $.evaluation.sns.form_validator(modal)

  for modal in $("div[id*=edit_sharp_and_smart_modal]")
    do ->
      $(modal).on "show.bs.modal", ->
        timeField = $(this).find('.datepicker')
        $.evaluation.target.activate_date_picker(timeField)

        $(this).find('#edit-sns').on 'click', (event)->
          $(this).parent().parent().find('#sns-form-edit').submit()

      $('body').delegate '#'+$(modal).attr('id'), "shown.bs.modal", (event) ->
        $.evaluation.sns.form_validator($(this))

  $('#sns_index_table').dataTable()

