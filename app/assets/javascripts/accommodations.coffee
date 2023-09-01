$ ->
  $('#new_accommodation').validate({
    rules:{
      "accommodation[adulthood_id]": {required: true}
      "accommodation[type_of_accommodation]": {required: true}
      "accommodation[cost]": {required: true}
    }
  })

  $.evaluation.special_activity.form_validator($('#sa-form'))
