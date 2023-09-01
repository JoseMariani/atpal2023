$ ->
  student_validator = $('#new_study_period').validate({
    rules: {
      "study_period[course_language]": {required: true}
      "study_period[program_id]": {required: true}
      "study_period[week_program_hours]": {required: true}
      "study_period[start_date]": {required: true}
      "study_period[end_date]": {required: true}
      "study_period[duration_weeks]": {required: true}
      "study_period[entire_stay_duration]": {required: true}
      "study_period[total_hours]": {required: true}
      "study_period[accommodation_id]": {required: true}
      "study_period[certificate_issued]": {required: true}
    }
  })

  $('#study_period_wizard').bootstrapWizard({
    'tabClass': 'nav nav-pills',
    'onNext': (tab, navigation, index) ->
      $valid = $('#new_study_period').valid()
      if !$valid
        student_validator.focusInvalid()
        return false
    'onTabShow': (tab, navigation, index) ->
      if index != 4
        $('#new_study_period_submit').addClass('hidden')
      else
        $('#new_study_period_submit').removeClass('hidden')
      $total = navigation.find('li').length
      $current = index+1
      $percent = ($current/$total) * 100
      $('#student_wizard .progress-bar').css({width:$percent+'%'})
    'onTabChange': (tab, navigation, index) ->
      $valid = $('#new_study_period').valid()
      if !$valid
        student_validator.focusInvalid()
        return false
  })

  if adulthood?
    accommodations = $('#study_period_accommodation_id').html()
    accommodation_options = $(accommodations).filter("optgroup[label='#{adulthood}']").html()
    if accommodation_options
      $('#study_period_accommodation_id').html(accommodation_options)

  states = $('#study_period_week_program_hours').html()
  $('#study_period_program_id').on 'change', ->
    program_id = $('#study_period_program_id :selected').val()
    program = $('#study_period_program_id :selected').text()
    options = $(states).filter("optgroup[label='#{program}']").html()
    if options
      $('#study_period_week_program_hours').html(options)
    else
      $('#study_period_program_hours').empty()
    $('select[name="study_period[program_cost]"]').val(program_id)

  hours = $('#study_period_week_program_hours').html()
  program = $('#study_period_program_id :selected').text()
  options = $(hours).filter("optgroup[label='#{program}']").html()
  if options
    $('#study_period_week_program_hours').html(options)
  else
    $('#study_period_week_program_hours').empty()
  $('#study_period_total_hours').on 'focus', ->
    $('#study_period_total_hours').val(parseInt($('#study_period_week_program_hours').text() * $('#weeks').val()))

  $('#sp_table').DataTable()
