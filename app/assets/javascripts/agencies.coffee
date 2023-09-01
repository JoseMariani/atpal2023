$ ->
  $('#new_agency').validate({
    rules:{
      "agency[name]": {required: true}
    }
  })

  $('#agency_user_ids').multiselect();