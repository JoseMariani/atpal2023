$ ->

  #events

  for modal in $("div[id*=new_attendance_modal]")
    do ->
      $(modal).on "hidden.bs.modal", ->
        $.evaluation.attendance.reset_modal($(this))

      $(modal).on "show.bs.modal", ->
        this_modal = $(this)
        absent_radio = $(this).find('#att_abs')

        absent_radio.on 'click', ->
          $.evaluation.attendance.set_absence(this_modal)

  for modal in $("div[id*=edit_attendance_modal]")
    do ->
      $(modal).on "show.bs.modal", ->
        this_modal = $(this)
        timeField = $(this).find('#edit_time-field')
        dateField = $(this).find('#edit-date-field')
        absent_radio = $(this).find('#att_abs')

        timeField.on 'blur', ->
          $.evaluation.attendance.calculate_grade_param($(this).closest('.modal'))

        absent_radio.on 'click', ->
          $.evaluation.attendance.set_absence(this_modal)

        $(this).find('#update_attendance').on 'click', (event)->
          $(this).parent().parent().find('#edit_attendance_form').submit()

  $('body').delegate '#time-field', "focusin", (evt)->
    timeField = $(this)
    $.evaluation.attendance.activate_time_picker_plugin(timeField)

  $('#attendances-link').click (event)->
    event.preventDefault()
    $('#attendance').fadeToggle()
    $('#attendance').focus()
    $(window).scrollTop($('#attendance').offset().top);

  $('body').delegate '#time-field', "blur", (evt)->
    $.evaluation.attendance.calculate_grade_param($(this).closest('.modal'))

  $('#attendance_index_table').dataTable()

  $('[data-toggle="tooltip"]').tooltip();


