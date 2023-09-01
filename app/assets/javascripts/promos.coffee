$ ->

  $('#promo_valid_until').datepicker
    dateFormat: 'dd-mm-yy'
    changeYear: true
    changeMonth: true

  $promo_forms = [$('#new_promo'), $('*[id*=edit_promo]:visible')]

  $promo_forms.forEach (element, index, array) ->
    element.validate({
      rules:{
        "promo[description]": {required: true}
        "promo[type_of_promo]": {required: true}
        "promo[percentage]": {required: true, digits:true, range: [1, 100]}
      }
    })
