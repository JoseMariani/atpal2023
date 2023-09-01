$.evaluation = {}

#############
# quiz helper
#############
$.evaluation.quiz = {}

$.evaluation.quiz.quiz_letter_grade_calculator = (quiz_form) ->

  quizGradeElem = $(quiz_form).find("[id*='grade']")[0]
  quizGradeA = $(quiz_form).find("[id*='quiz_letter_a']")[0]
  quizGradeB = $(quiz_form).find("[id*='quiz_letter_b']")[0]
  quizGradeC = $(quiz_form).find("[id*='quiz_letter_c']")[0]

  $(quizGradeElem).on 'focusout', ->
    grade = $(this).val()
    if grade > 89 and grade <= 100
      $(quizGradeA).prop 'checked', true
    else if grade > 75 and grade <=89
      $(quizGradeB).prop 'checked', true
    else if grade <= 75
      $(quizGradeC).prop 'checked', true

$.evaluation.quiz.form_validator = (quiz_form) ->

  $(quiz_form).validate({
    rules: {
      "quiz[date]": {required: true}
      "quiz[chapter]": {required: true}
      "quiz[grade_percentage]": {required: true, number: true}
      "quiz[letter_grade]": {required: true}
    }})

$.evaluation.quiz.set_date_picker_plugin = (quiz_form) ->

  autoDate = $(quiz_form).find("[id*='date']")[0]
  $(autoDate).datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true

$.evaluation.quiz.clear_modal = (modal) ->

  quizDateElem = $(modal).find("[id*='date']")[0]
  quizChapterElem = $(modal).find("[id*='chapter']")[0]
  quizGradeElem = $(modal).find("[id*='grade']")[0]
  quizGradeA = $(modal).find("[id*='quiz_letter_a']")[0]
  quizGradeB = $(modal).find("[id*='quiz_letter_b']")[0]
  quizGradeC = $(modal).find("[id*='quiz_letter_c']")[0]

  $(quizDateElem).val("")
  $(quizChapterElem).val("")
  $(quizGradeElem).val("")
  $(quizGradeA).prop('checked', false);
  $(quizGradeB).prop('checked', false);
  $(quizGradeC).prop('checked', false);

$.evaluation.special_activity = {}

$.evaluation.special_activity.form_validator = (form) ->

  $(form).validate({
    rules: {
      "special_activity[date]": {required: true}
      "special_activity[description]": {required: true}
      "special_activity[research_grade]": {required: true}
      "special_activity[presentation_grade]": {required: true}
      "special_activity[written_grade]": {required: true}
      "special_activity[letter_grade]": {required: true}
    }
  })

$.evaluation.attendance = {}

$.evaluation.attendance.covert_to_24 = (time) ->

  hours = Number(time.match(/^(\d+)/)[1])
  minutes = Number(time.match(/:(\d+)/)[1])
  AMPM = time.match(/\s(.*)$/)[1]
  if (AMPM == "PM" && hours < 12)
    hours = hours + 12
  if (AMPM == "AM" && hours == 12)
    hours = hours - 12
  sHours = hours.toString()
  sMinutes = minutes.toString()
  if (hours < 10)
    sHours = "0" + sHours
  if (minutes < 10)
    sMinutes = "0" + sMinutes
  return sHours + ":" + sMinutes

$.evaluation.attendance.calculate_grade_param = (modal) ->

  limit_grade_and_penalty = (mark) ->
    corrected_mark = switch
      when mark < 0 then 0
      when mark > 100 then 100
      else mark
    corrected_mark

  late_time = new Date
  late_time.setHours(9, 15)
  on_time = true
  penalty = 0
  grade = 0
  time_field_value = modal.find('#edit_time-field').val() || modal.find('#time-field').val()
  minutes = $.evaluation.attendance.covert_to_24(time_field_value).split ":"
  if late_time.getMinutes() >= minutes[1] and late_time.getHours() >= minutes[0]
    on_time = true
  else
    on_time = false
  if !on_time
    if minutes[0] >= 14
      penalty = 1
      grade = 0
    else
      minutes_in_hours = minutes[0] - late_time.getHours()
      minutes_in_hours = minutes_in_hours * 60
      total_penalty_minutes = parseInt(minutes[1]) +  parseInt(minutes_in_hours)
      penalty = limit_grade_and_penalty(total_penalty_minutes / 300)
      grade = limit_grade_and_penalty(100 - penalty * 100)
  else
    penalty = 0
    grade = 100
  modal.find('#penalty').val((penalty * 100).toFixed(2))
  modal.find('#grade').val((grade).toFixed(2))
  modal.find('#att_pres').prop("checked", true)

$.evaluation.attendance.activate_time_picker_plugin = (timeField) ->
  date = timeField.val()
  if date? && date != ""
    date = moment(date).format('YYYY MM DD hh:mm a')
  else
    date = moment(new Date()).format('YYYY MM DD hh:mm a')
  timeField.val(moment(date).format('hh:mm a'))
  timeField.datetimepicker({
    defaultDate: date,
    format: "LT",
  })

$.evaluation.attendance.activate_date_picker_plugin = (timeField) ->
  date = timeField.val()
  if date? && date != ""
    date = moment(date).format('YYYY MM DD hh:mm a')
  else
    date = moment(new Date()).format('YYYY MM DD hh:mm a')
  timeField.val(moment(date).format('MMMM DD, YYYY'))
  timeField.datetimepicker({
    defaultDate: date,
    format: "LL",
  })

$.evaluation.attendance.reset_modal = (modal) ->
  $(modal).find('#time-field').val("")
  $(modal).find('#penalty').val("100.00")
  $(modal).find('#grade').val("0.00")
  $(modal).find('#att_abs').prop('checked', true);
  $(modal).find('#att_pres').prop('checked', false);

$.evaluation.attendance.set_absence = (modal) ->
  timefield = if $(modal).find('#time-field').length then '#time-field' else '#edit_time-field'
  $(modal).find(timefield).val('')
  $(modal).find('#penalty').val(100.toFixed(2))
  $(modal).find('#grade').val(0)
  $(modal).find('#att_pres').prop("checked", false)

$.evaluation.target = {}

$.evaluation.target.activate_date_picker = (timeField) ->

  $(timeField).datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true
    minDate: "-2W"

$.evaluation.target.form_validator = (modal) ->

  $(modal).find('form').validate({
    rules: {
      "target[date]": {required: true}
      "target[description]": {required: true}
      "target[student_input]": {required: true, number: true}
      "target[letter_grade]": {required: true}
    }})

$.evaluation.target.reset_modal = (modal) ->

  $(modal).find('.datepicker').datepicker('setDate', null)
  $(modal).find('#description').val("")
  $(modal).find('#student_input').val("")
  $(modal).find('#target_a').prop('checked', false)
  $(modal).find('#target_b').prop('checked', false)
  $(modal).find('#target_c').prop('checked', false)

$.evaluation.sns = {}

$.evaluation.sns.reset_modal = (modal) ->

  $(modal).find('#sns_1').prop('checked', false)
  $(modal).find('#sns_2').prop('checked', false)
  $(modal).find('#sns_3').prop('checked', false)
  $(modal).find('#sns_4').prop('checked', false)
  $(modal).find('#sns_5').prop('checked', false)

$.evaluation.sns.form_validator = (modal) ->

  $(modal).find('form').validate({
    rules: {
      "sharp_and_smart[date]": {required: true}
      "sharp_and_smart[score]": {required: true}
    }})

$.evaluation.automatization = {}

$.evaluation.automatization.reset_modal = (modal) ->

  $(modal).find('.datepicker').datepicker('setDate', null)
  $(modal).find('#automatization_description').val("")
  $(modal).find('#automatization_a').prop('checked', false)
  $(modal).find('#automatization_b').prop('checked', false)
  $(modal).find('#automatization_c').prop('checked', false)

$.evaluation.automatization.form_validator = (modal) ->

  $(modal).find('form').validate({
    rules: {
      "automatization[date]": {required: true}
      "automatization[description]": {required: true}
      "automatization[letter_grade]": {required: true}
    }})

$.evaluation.automatization.activate_date_picker = (timeField) ->

  $(timeField).datepicker({ dateFormat: 'yy-mm-dd', changeYear: true, changeMonth: true })
  date = $.datepicker.parseDate('yy-mm-dd', $(timeField).val())
  $(timeField).datepicker('setDate', date)

$.evaluation.test = {}

$.evaluation.test.set_date_picker_plugin = (test_form) ->

  autoDate = $(test_form).find("[id*='date']")[0]
  $(autoDate).datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true

$.evaluation.test.form_validator = (test_form) ->

  $(test_form).validate({
    rules: {
      "test[date]": {required: true}
      "test[chapter]": {required: true}
      "test[grade_percentage]": {required: true, number: true}
      "test[letter_grade]": {required: true}
    }})

$.evaluation.test.clear_modal = (modal) ->

  testDateElem = $(modal).find("[id*='date']")[0]
  testLevelElem = $(modal).find("[id*='level']")[0]
  testGradeElem = $(modal).find("[id*='grade']")[0]
  testGradeA = $(modal).find("[id*='letter_a']")[0]
  testGradeB = $(modal).find("[id*='letter_b']")[0]
  testGradeC = $(modal).find("[id*='letter_c']")[0]

  $(testDateElem).val("")
  $(testLevelElem).val("")
  $(testGradeElem).val("")
  $(testGradeA).prop('checked', false);
  $(testGradeB).prop('checked', false);
  $(testGradeC).prop('checked', false);

$.evaluation.test.letter_grade_calculator = (form) ->

  quizGradeElem = $(form).find("[id*='grade']")[0]
  quizGradeA = $(form).find("[id*='letter_a']")[0]
  quizGradeB = $(form).find("[id*='letter_b']")[0]
  quizGradeC = $(form).find("[id*='letter_c']")[0]

  $(quizGradeElem).on 'focusout', ->
    grade = $(this).val()
    if grade > 89 and grade <= 100
      $(quizGradeA).prop 'checked', true
    else if grade > 75 and grade <=89
      $(quizGradeB).prop 'checked', true
    else if grade <= 75
      $(quizGradeC).prop 'checked', true