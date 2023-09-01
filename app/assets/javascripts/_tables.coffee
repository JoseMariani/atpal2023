$ ->
	table = $('#student_table').DataTable(
		{
      ajax: "/students/student_list.json",
      processing: true,
      serverSide: true,

      columns: [
        { data: 'last_name' },
        { data: 'first_name' },
        { data: 'nationality' },
        { data: 'passport_number' },
        { data: 'date_of_birth' },
        { data: 'start_date' },
        { data: 'end_date' },
        { data: 'course_language' },
        { data: 'insurance' },
        { data: 'residential_address' },
        { data: 'address_in_canada' },
        { data: 'caq' },
        { data: 'airport_transfer' },
        { data: 'duration_weeks' },
        { data: 'student_id' },
        { data: 'balance' },
        { data: 'visa' },
        { data: 'air_ticket' },
        { data: 'arrival_date' },
        { data: 'email_address' },
        { data: 'certificate_issued' },
        { data: 'gender' },
        { data: 'age' },
        { data: 'phone_number' },
        { data: 'program' },
        { data: 'total_hours' },
        { data: 'region' },
        { data: 'agency' },
        { data: 'type_of_accommodation' },
        { data: 'status' },
        { data: 'total_amount' },
        { data: 'created_at' },
        { data: 'emergency_email' },
      ],
      columnDefs: [
          {
              "targets": [ 3 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 4 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 7 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 8 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 9 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 10 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 11 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 12 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 13 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 16 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 17 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 18 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 19 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 20 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 21 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 22 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 23 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 25 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 26 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 27 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 28 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 30 ],
              "visible": false,
              className: 'none'
          },
          {
              "targets": [ 31 ],
              "visible": false,
              className: 'none'
          },
          {
            "targets": [ 32 ],
            "visible": false,
            className: 'none'
          },
      ],
	    })

	$('a.toggle-vis').on 'click', (e) ->
        e.preventDefault()

        column = table.column( $(this).attr('data-column') )

        column.visible( ! column.visible() )

  $('table.display').dataTable()
