# Place all the behaviors and hooks related to the matching controller here.
# All this logic  ill automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

(->
  moment = undefined
  moment = if typeof require != 'undefined' and require != null and !require.amd then require('moment') else @moment

  moment.fn.businessDiff = (start) ->
    start = moment(start)
    end = @clone()
    start_offset = start.day() - 7
    end_offset = end.day()
    end_sunday = end.clone().subtract(end_offset,'d')
    start_sunday = start.clone().subtract(start_offset, 'd')
    weeks = end_sunday.diff(start_sunday, 'days') / 7
    start_offset = Math.abs(start_offset)
    if (start.isoWeekday() != 6 && start.isoWeekday() != 7)
      start_offset++
    if start_offset == 7
      start_offset = 5
    else if start_offset == 1
      start_offset = 0
    else
      start_offset -= 2
    if end_offset == 6
      end_offset--
    Math.round((weeks * 5 + start_offset + end_offset) / 5)

  moment.fn.businessAdd = (days) ->
    d = @clone().add('d', Math.floor(days / 5) * 7)
    remaining = days % 5
    while remaining
      d.add 'd', 1
      if d.day() != 0 and d.day() != 6
        remaining--
    d

  return
).call this

populate_date = (date_field, value) ->
  if ($(date_field) == "" or isNaN(date_field))
    $(date_field).val(value)

populate_total_accommodation_weeks = (value) ->
  if $('#acco_weeks').val() == ""
    $('#acco_weeks').val(value)

populate_total_insurance_weeks = (value) ->
  if ($('#study_period_insurance_cover_period').val() == "" and $('#study_period_insurance_id option:selected').text() != "")
    $('#study_period_insurance_cover_period').val(value)

populate_total_insurance_weeks_from_study_periods = () ->
  if ($('#weeks').val() != "" and $('#study_period_insurance_cover_period').val() == "")
    $('#study_period_insurance_cover_period').val($('#weeks').val())

populate_insurance_fields = () ->
  populate_date('#study_period_start_date_insurance', $('#student_start_date').val())
  populate_date('#study_period_end_date_insurance', $('#student_end_date').val())
  populate_total_insurance_weeks_from_study_periods()

clear_insurance_fields = () ->
  $('#study_period_start_date_insurance').val('')
  $('#study_period_end_date_insurance').val('')
  $('#study_period_insurance_cover_period').val('')

$ ->

	$('#student_date_of_birth').datepicker
    dateFormat: 'yy-mm-dd'
    yearRange: "-100:+0"
    changeYear: true
    changeMonth: true
    minDate: "-80Y"
    maxDate: "-1Y"

	$('#student_start_date').datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true

	$('#student_end_date').datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true

  $('#study_period_start_date_accommodation').datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true

  $('#study_period_end_date_accommodation').datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true

  $('#study_period_start_date_insurance').datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true

  $('#study_period_end_date_insurance').datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true

	$('#valid_until').datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true
    minDate: "+1D"

	$('#student_arrival_date').datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true
    minDate: "+1D"

  $('#study_period_insurance_id').on 'change', ->
    if $("option:selected", this).text() != "" then populate_insurance_fields() else clear_insurance_fields()

  if $('#study_period_certificate_issued option').filter(':selected').text() == "Certificate issued"
    $('.certificate_picture').show()
  else
    $('.certificate_picture').hide()

  $('#study_period_certificate_issued').change ->
    if $('#study_period_certificate_issued option').filter(':selected').text() == "Certificate issued"
      $('.certificate_picture').show()
    else
      $('.certificate_picture').hide()

  $('#student_start_date').on 'change', ->
    weekto = $('#student_end_date').datepicker('getDate')
    weekfrom = $('#student_start_date').datepicker('getDate')
    totalWeeks = moment(weekto).businessDiff(moment(weekfrom))
    if $('#study_period_insurance_id option:selected').text() != ""
      populate_date('#study_period_start_date_insurance', $(this).val())
    if totalWeeks && isNaN(totalWeeks)?
      $('#weeks').val(totalWeeks)
      $('#entire_weeks').val(totalWeeks)
      $('#ro_weeks').val(totalWeeks)
      $('#quote_program_total').trigger "focus"
      populate_total_insurance_weeks(totalWeeks)

	$('#student_end_date').on 'change', ->
    weekto = $('#student_end_date').datepicker('getDate')
    weekfrom = $('#student_start_date').datepicker('getDate')
    totalWeeks = moment(weekto).businessDiff(moment(weekfrom))
    if $('#study_period_insurance_id option:selected').text() != ""
      populate_date('#study_period_end_date_insurance', $(this).val())
    if totalWeeks && isNaN(totalWeeks)?
      $('#weeks').val(totalWeeks)
      $('#entire_weeks').val(totalWeeks)
      $('#ro_weeks').val(totalWeeks)
      $('#quote_program_total').trigger "focus"
      populate_total_insurance_weeks(totalWeeks)

  $('#study_period_start_date_accommodation').on 'change', ->
    weekto = $('#study_period_end_date_accommodation').datepicker('getDate')
    weekfrom = $('#study_period_start_date_accommodation').datepicker('getDate')
    totalWeeks = moment(weekto).businessDiff(moment(weekfrom))
    if totalWeeks && isNaN(totalWeeks)?
      $('#acco_weeks').val(totalWeeks)

  $('#study_period_end_date_accommodation').on 'change', ->
    weekto = $('#study_period_end_date_accommodation').datepicker('getDate')
    weekfrom = $('#study_period_start_date_accommodation').datepicker('getDate')
    totalWeeks = moment(weekto).businessDiff(moment(weekfrom))
    if totalWeeks && isNaN(totalWeeks)?
      $('#acco_weeks').val(totalWeeks)

  $('#study_period_start_date_insurance').on 'change', ->
    if $('#study_period_insurance_id option:selected').text() != ""
      weekto = $('#study_period_end_date_insurance').datepicker('getDate')
      weekfrom = $('#study_period_start_date_insurance').datepicker('getDate')
      totalWeeks = moment(weekto).businessDiff(moment(weekfrom))
      if totalWeeks && isNaN(totalWeeks)?
        $('#study_period_insurance_cover_period').val(totalWeeks)
    else
      $(this).val("")

  $('#study_period_end_date_insurance').on 'change', ->
    if $('#study_period_insurance_id option:selected').text() != ""
      weekto = $('#study_period_end_date_insurance').datepicker('getDate')
      weekfrom = $('#study_period_start_date_insurance').datepicker('getDate')
      totalWeeks = moment(weekto).businessDiff(moment(weekfrom))
      if totalWeeks && isNaN(totalWeeks)?
        $('#study_period_insurance_cover_period').val(totalWeeks)
    else
      $(this).val("")

	$('#student_date_of_birth').on 'change', ->
    today = new Date()
    dob = new Date($('#student_date_of_birth').val())
    age = today.getTime()- dob.getTime()
    age = age // (1000 * 60 * 60 * 24 * 365.25)
    $('#age').val(age)
    assign_adulthood($('#age').val())
    accommodations = $('#student_accommodation_id').html()
    legal_age = $('#student_adulthood_id option').filter(':selected').text()
    accommodation_options = $(accommodations).filter("optgroup[label='#{legal_age}']").html()
    if accommodation_options
      $('#student_accommodation_id').html(accommodation_options)


	hours = $('#student_week_program_hours').html()
	program = $('#student_program_id :selected').text()
	options = $(hours).filter("optgroup[label='#{program}']").html()
	if options
		$('#student_week_program_hours').html(options)
	else
		$('#student_week_program_hours').empty()
	$('#student_total_hours').on 'focus', ->
		$('#student_total_hours').val(parseInt($('#student_week_program_hours').text() * $('#weeks').val()))

  assign_adulthood = (age) ->
    adulthood_selector = $('select[name="student[adulthood_id]"]')
    if age >= 18
      adulthood_selector.val(2)
    else
      adulthood_selector.val(1)


## accommodation selection
  accommodations = $('#student_accommodation_id').html()
  $('#student_adulthood_id').change ->
    legal_age = $('#student_adulthood_id option').filter(':selected').text()
    accommodation_options = $(accommodations).filter("optgroup[label='#{legal_age}']").html()
    if accommodation_options
      $('#student_accommodation_id').html(accommodation_options)
    else
      $('#student_accommodation_id').html(" ")

  $('#new_student_submit').click ->
    $('#hidden_complete_name').val($('#student_first_name').val() + " " + $('#student_last_name').val())

  $('#edit_submit').click ->
    $('#hidden_complete_name').val($('#student_first_name').val() + " " + $('#student_last_name').val())

  airport_options = ["Choose one option", "None"]
  if $.inArray($('#student_airport_transfer option').filter(':selected').text(), airport_options) > -1
    $('.itinerary').hide()
  else
    $('.itinerary').show()

  $('#student_airport_transfer').change ->
    if $.inArray($('#student_airport_transfer option').filter(':selected').text(), airport_options) > -1
      $('.itinerary').hide()
    else
      $('.itinerary').show()
