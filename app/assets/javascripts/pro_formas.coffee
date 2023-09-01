$ ->

#variables
  item_count = 0
  item_serialized_index = 0
  placement_index = 0
  #functions

  ## function and statements to handle the choosing of type of program,
  # hours, and cost
  try
    $('#ro_pro_forma_program_cost').val($('#pro_forma_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))
  catch error

  $('#ro_pro_forma_weeks').val($("#weeks").val())
  $('#pro_forma_program_total').val(($('#ro_pro_forma_program_cost').val() * $('#ro_pro_forma_weeks').val()).toFixed(2))
  $('#pro_forma_accommodation_total').val(parseFloat($('select[name="pro_forma[accommodation_cost]"]').val($('#pro_forma_accommodation_id :selected').text()) * $('#pro_forma_accommodation_duration').val()))

  get_program_total = ->
    try
      $('#ro_pro_forma_program_cost').val($('#pro_forma_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))
    catch error

    if $('#pro_forma_promo_ids :selected').text() != ""
      pro_forma_promos_prct = $.fn.billing.get_promos($('#pro_forma_promo_ids :selected'))
      try
        pro_forma_local_program_total = $('#pro_forma_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', '')
      catch error

      for i in [0..pro_forma_promos_prct.length-1]
        $('#ro_pro_forma_program_cost').val($.fn.billing.get_temporary_program_cost(pro_forma_local_program_total, pro_forma_promos_prct[i]))
        pro_forma_local_program_total = $('#ro_pro_forma_program_cost').val()
    $('#ro_pro_forma_weeks').val($("#weeks").val())
    $('#pro_forma_program_total').val(parseFloat($('#ro_pro_forma_program_cost').val() * $('#ro_pro_forma_weeks').val()).toFixed(2))

  get_accommodation_total = ->
    $('#ro_pro_forma_accommodation_cost').val($('#pro_forma_accommodation_cost :selected').text())
    $('#pro_forma_accommodation_total').val(parseFloat($('#ro_pro_forma_accommodation_cost').val() *
        $('#pro_forma_accommodation_duration').val()))

  get_partial_total = ->
    pro_forma_items_total = window.item_total
    if isNaN(pro_forma_items_total)
      pro_forma_items_total = 0
    pro_forma_app_total = parseFloat($('#app_total').val())
    if isNaN(pro_forma_app_total) || !pro_forma_app_total? || pro_forma_app_total == ""
      pro_forma_app_total = 0
    pro_forma_accommodation_cost = parseFloat($('#pro_forma_accommodation_total').val())
    pro_forma_program_cost = parseFloat($('#pro_forma_program_total').val())
    pro_forma_insurance_cost = parseFloat($('#pro_forma_insurance_cost').val())
    $('#pro_forma_grand_total').val(parseFloat(pro_forma_items_total) + parseFloat(pro_forma_accommodation_cost) + parseFloat(pro_forma_program_cost) + parseFloat(pro_forma_app_total) + pro_forma_insurance_cost)

  pro_forma_hours = $('#pro_forma_program_week_range').html()
  $('#pro_forma_program_id').on 'change', ->
    pro_forma_program_id = $('#pro_forma_program_id :selected').val()
    pro_forma_program = $('#pro_forma_program_id :selected').text()
    pro_forma_options = $(pro_forma_hours).filter("optgroup[label='#{pro_forma_program}']").html()
    if pro_forma_options
      $('#pro_forma_program_week_range').html(pro_forma_options)
    else
      $('#pro_forma_program_week_range').empty()
    $('select[name="pro_forma[program_cost]"]').val(pro_forma_program_id)

  pro_forma_hours = $('#pro_forma_program_week_range').html()
  pro_forma_program_id = $('#pro_forma_program_id :selected').val()
  pro_forma_program = $('#pro_forma_program_id :selected').text()
  pro_forma_options = $(pro_forma_hours).filter("optgroup[label='#{pro_forma_program}']").html()
  if pro_forma_options
    $('#pro_forma_program_week_range').html(pro_forma_options)
  else
    $('#pro_forma_program_week_range').empty()
  $('select[name="pro_forma[program_cost]"]').val(pro_forma_program_id)

  $('#pro_forma_program_week_range').on 'change', ->
    try
      $('#ro_pro_forma_program_cost').val($('#pro_forma_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))
    catch error

    get_program_total()
  ########### end of type of program statements

  ## Total number of hours calculation
  pro_forma__program_id = $('#pro_forma_program_id :selected').val()
  pro_forma__program = $('#pro_forma_program_id :selected').text()
  pro_forma_options = $(pro_forma_hours).filter("optgroup[label='#{pro_forma_program}']").html()
  if pro_forma_options
    $('#pro_forma_week_program_hours').html(pro_forma_options)
  else
    $('#pro_forma_week_program_hours').empty()
  #######################################


  $('#pro_forma_grand_total').on 'focus', ->
    get_partial_total()

  $('#create-quote').on 'click', ->
    get_program_total()
    get_partial_total()
    try
      $('#pro_forma_post_rebate_program_cost').val($('#pro_forma_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))
    catch error

  ## promos
  promotions = $('#pro_forma_promo_ids').html()
  $.fn.billing.extract_promos($('#pro_forma_region_id :selected'), promotions, $('#pro_forma_promo_ids'))

  $('#pro_forma_region_id').change ->
    $.fn.billing.extract_promos($('#pro_forma_region_id :selected'), promotions, $('#pro_forma_promo_ids'))

  ## accommodation functions and variables
  pro_forma_accommodations = $('#pro_forma_accommodation_id').html()
  $('#pro_forma_adulthood_id').on 'change', ->
    pro_forma_adulthood_id = $('#pro_forma_adulthood_id :selected').val()
    pro_forma_adulthood = $('#pro_forma_adulthood_id :selected').text()
    pro_forma_accommodation_options = $(pro_forma_accommodations).filter("optgroup[label='#{pro_forma_adulthood}']").html()
    if pro_forma_accommodation_options
      $('#pro_forma_accommodation_id').html(pro_forma_accommodation_options)
    else
      $('#pro_forma_accommodation_id').empty()
    $('select[name="pro_forma[accommodation_cost]"]').val($('#pro_forma_accommodation_id :selected').val())

  $('#pro_forma_accommodation_id').on 'change', ->
    pro_forma_accommodation_id = $('#pro_forma_accommodation_id').val()
    $('select[name="pro_forma[accommodation_cost]"]').val(pro_forma_accommodation_id)
    get_accommodation_total()


  pro_forma_accommodations = $('#pro_forma_accommodation_id').html()
  pro_forma_adulthood_id = $('#pro_forma_adulthood_id :selected').val()
  pro_forma_adulthood = $('#pro_forma_adulthood_id :selected').text()
  pro_forma_accommodation_options = $(pro_forma_accommodations).filter("optgroup[label='#{pro_forma_adulthood}']").html()
  if pro_forma_accommodation_options
    $('#pro_forma_accommodation_id').html(pro_forma_accommodation_options)
  else
    $('#pro_forma_accommodation_id').empty()
  $('select[name="pro_forma[accommodation_cost]"]').val($('#pro_forma_accommodation_id :selected').val())

  pro_forma_accommodation_id = $('#pro_forma_accommodation_id').val()
  $('select[name="pro_forma[accommodation_cost]"]').val(pro_forma_accommodation_id)
  ########################

  $('#pro_forma_adulthood_id').on 'change', ->
    get_accommodation_total()

  $('#weeks').on 'input propertychange', ->
    get_program_total()

  $('#pro_forma_program_id').change ->
    get_program_total()

  $('#pro_forma_program_total').focus ->
    get_program_total()

  $('#pro_forma_accommodation_duration').on 'input propertychange', ->
    get_accommodation_total()

  get_program_total()

  get_accommodation_total()

  $('#promo_btn').click ->
    get_program_total()

  $pro_validator = $('#new_pro_forma').validate({
    rules: {
      "pro_forma[first_name]": {required: true}
      "pro_forma[last_name]": {required: true}
      "pro_forma[adulthood_id]": {required: true}
      "pro_forma[accommodation_id]": {required: true}
      "pro_forma[region_id]": {required: true}
      "pro_forma[course_language]": {required: true}
      "pro_forma[program_id]": {required: true}
      "pro_forma[week_program_hours]": {required: true, digits:true}
      "pro_forma[program_cost]": {required: true, number:true}
      "pro_forma[start_date]": {required: true}
      "pro_forma[end_date]": {required: true}
      "pro_forma[entire_stay_duration]": {required: true, digits:true}
      "pro_forma[duration_weeks]": {required: true, digits:true}
      "pro_forma[email_address]": {required: true, email:true}
      "pro_forma[date_of_validity]": {required: true}
      "pro_forma[agency_id]": {required: true}
      'pro_forma[promo_ids][]': {
        required: true,
        minlength: 1
      }
    },
    messages: {
      'pro_forma[promo_ids][]': "Please select at least one promo"
    }
  })

  $('#pro_forma_wizard').bootstrapWizard({
    'tabClass': 'nav nav-pills',
    'onNext': (tab, navigation, index) ->
      $valid = $("#new_pro_forma").valid()
      if !$valid
        $pro_validator.focusInvalid()
        return false
    'onTabShow': (tab, navigation, index) ->
      if index != 7
        $('#create-quote').addClass('hidden')
      else
        $('#create-quote').removeClass('hidden')
      $total = navigation.find('li').length
      $current = index+1
      $percent = ($current/$total) * 100
      $('#pro_forma_wizard .progress-bar').css({width:$percent+'%'})
    'onTabChange': (tab, navigation, index) ->
      $valid = $('#new_pro_forma').valid()
      if !$valid
        $pro_validator.focusInvalid()
        return false
    'onFinish': (tab, navigation, index) ->
      $total = navigation.find('li').length
      $current = index+1
      $percent = ($current/$total) * 100
      $('#pro_forma_wizard .progress-bar').css({width:$percent+'%'})
  })

  if $('.pro-forma-forms').length > 0

    $.when($.fn.billing.get_insurance_total_partial("#pro_forma_insurance_id", 'pro_forma', "#pro_forma_insurance_cover_period")).done ->
      $.fn.billing.update_insurance_total('pro_forma', $('#pro_forma_insurance_cover_period').val())

    $.fn.billing.update_insurance_cost('pro_forma')

    for date in $('input[id*=date_accommodation]')
      $.fn.billing.automate_date_picking(date, '#pro_forma_start_date_accommodation', '#pro_forma_end_date_accommodation',
        '#pro_forma_accommodation_duration', get_accommodation_total)

    for date in $('input[id*=date_insurance]')
      $.fn.billing.automate_date_picking(date, '#pro_forma_start_date_insurance', '#pro_forma_end_date_insurance',
        '#pro_forma_insurance_cover_period', $.fn.billing.update_insurance_total, 'pro_forma')
