$ ->


	$('#program_table').DataTable()
	conceptName = $('#student_program_id').find(":selected").text()
	
	$('.selected_program').on 'change', ->
		conceptName = $('#student_program_id').find(":selected").text()

	$('#new_program, .edit_program').validate({
   		rules: {
    	"program[title]": {required: true}
    	}
  	})