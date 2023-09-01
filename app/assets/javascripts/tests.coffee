$ ->

	$.evaluation.test.set_date_picker_plugin($('#tests-form'))

	$.evaluation.test.form_validator($('#tests-form'))
	 
	$("#new_test_modal").on "hidden.bs.modal", ->
    $.evaluation.test.clear_modal("#new_test_modal")
    	
	$.evaluation.test.letter_grade_calculator('#tests-form')
