$ ->

	$('#sa-link').click (event)->
		event.preventDefault()
		$('#sa').fadeToggle()
		$('#sa').focus()
		$(window).scrollTop($('#sa').offset().top);

	$("body").delegate '#sa_date', "focusin", ->
		$(this).datepicker({ dateFormat: 'dd-mm-yy', changeYear: true, changeMonth: true })

	$("#new_activity_modal").on "hidden.bs.modal", ->
    	$('#sa_date').val("")
    	$('#sa_description').val("")
    	$('#sar_a').prop('checked', false);
    	$('#sar_b').prop('checked', false);
    	$('#sar_c').prop('checked', false);
    	$('#sap_a').prop('checked', false);
    	$('#sap_b').prop('checked', false);
    	$('#sap_c').prop('checked', false);
    	$('#saw_a').prop('checked', false);
    	$('#saw_b').prop('checked', false);
    	$('#saw_c').prop('checked', false);
    	$('#sa_a').prop('checked', false);
    	$('#sa_b').prop('checked', false);
    	$('#sa_c').prop('checked', false);

  $("#edit_activity_modal").on "shown.bs.modal", ->

    $.evaluation.quiz.set_date_picker_plugin($('#edit_special_activity_form'))

    $('#update_special_activity').on 'click', ->
      $('#edit_special_activity_form').submit
