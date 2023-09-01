json.draw @data[:draw]
json.recordsTotal @data[:total_records]
json.recordsFiltered @data[:records_filtered]

json.set! :data do
  json.array! @students do |student|
    json.first_name link_to student.first_name.split.map(&:capitalize).join(' '), student_path(student.id)
    json.last_name link_to student.last_name.split.map(&:capitalize).join(' '), student_path(student.id)
    json.nationality student.nationality
    json.passport_number student.passport_number
    json.date_of_birth student.date_of_birth
    json.start_date student.study_period_start_date
    json.end_date student.study_period_end_date
    json.course_language student.study_period_course_language
    json.insurance student.insurance
    json.residential_address student.residential_address
    json.address_in_canada student.address_in_canada
    json.caq student.caq
    json.airport_transfer student.airport_transfer
    json.duration_weeks student.study_period_duration_weeks
    json.student_id student.student_id
    json.balance to_cad(student.study_period_balance)
    json.visa student.visa
    json.air_ticket student.air_ticket
    json.arrival_date student.study_period_arrival_date
    json.email_address student.email_address
    json.certificate_issued student.study_period_certificate_issued
    json.gender student.gender
    json.age student.age
    json.phone_number student.phone_number
    json.program student.latest_program_title
    json.total_hours student.study_period_total_hours
    json.region student.region_name
    json.agency student.agency_name
    json.type_of_accommodation student.latest_accommodation_title
    json.status student.status
    json.total_amount to_cad(student.study_period_total_amount)
    json.created_at student.created_at.to_formatted_s(:long)
    json.emergency_email student.emergency_email
  end
end


