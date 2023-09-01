$ ->
  $('.regions_id').validate({
    rules:{
      "region[name]": {required: true}
      "accommodation[type_of_accommodation]": {required: true}
      'region[promo_ids][]': {
        required: true,
        minlength: 1
      }
    },
    messages: {
      'region[promo_ids][]': "Please select at least one promo"
    }
  })
