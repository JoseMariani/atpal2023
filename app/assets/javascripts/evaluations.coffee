$ ->

  console.log('ok')

  $('#new_evaluation').validate({
    rules: {
      "evaluation[end_date]": {required: true}
    }
  })

  $('#edit_multiple_student').validate({
    rules: {
      "students[][level]": {required: true}
    }
  })

  $('#start-date-graph').datepicker({ dateFormat: 'dd/mm/yy', changeYear: true, changeMonth: true })
  $('#end-date-graph').datepicker({ dateFormat: 'dd/mm/yy', changeYear: true, changeMonth: true })

  $('.options-icon').click ->
    if $('.dropdown.dropdown-graph-dates').hasClass('hidden')
      $('.dropdown.dropdown-graph-dates').removeClass('hidden')
    else
      $('.dropdown.dropdown-graph-dates').addClass('hidden')

  $('.dropdown.dropdown-graph-dates').on "shown.bs.dropdown", (event) ->
    if $('#start-date-graph').datepicker( "widget" ).is(":visible") or $('#end-date-graph').datepicker( "widget" ).is(":visible")
      this.closable = false
    else
      this.closable = true

  $('.dropdown.dropdown-graph-dates').on "click", ->
    this.closable = true

  $('.dropdown.dropdown-graph-dates').on "hide.bs.dropdown", ->
    if $('#start-date-graph').datepicker( "widget" ).is(":visible") or $('#end-date-graph').datepicker( "widget" ).is(":visible")
      this.closable = false
    else
      this.closable = true
