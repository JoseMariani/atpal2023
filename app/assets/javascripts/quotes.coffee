$ ->

  #variables
  item_count = 0
  item_serialized_index = 0
  placement_index = 0
  app_total = 0
  window.item_total = 0

  #functions
  ## function and statements to handle the choosing of type of program,
  # hours, and cost
  try
    $('#ro_quote_program_cost').val($('#quote_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))
  catch error

  $('#ro_weeks').val($("#weeks").val())
  $('#quote_program_total').val(($('#ro_quote_program_cost').val() * $('#ro_weeks').val()))
  $('#quote_accommodation_total').val(parseFloat($('select[name="quote[accommodation_cost]"]').val($('#quote_accommodation_id :selected').text()) * $('#quote_accommodation_duration').val()))

  get_program_total = ->
    try
      $('#ro_quote_program_cost').val(($('#quote_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', '')))
    catch error

    if $('#quote_promo_ids :selected').text() != ""
      promos_prct = $.fn.billing.get_promos($('#quote_promo_ids :selected'))
      try
        local_program_total = $('#quote_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', '')
      catch error

      for i in [0..promos_prct.length-1]
        $('#ro_quote_program_cost').val($.fn.billing.get_temporary_program_cost(local_program_total, promos_prct[i]))
        local_program_total = $('#ro_quote_program_cost').val()
    $('#ro_weeks').val($("#weeks").val())
    $('#quote_program_total').val((parseFloat($('#ro_quote_program_cost').val() * $('#ro_weeks').val())))

  get_accommodation_total = ->
    $('#ro_quote_accommosation_cost').val($('#quote_accommodation_cost :selected').text())
    $('#quote_accommodation_total').val(parseFloat($('#ro_quote_accommosation_cost').val() * $('#quote_accommodation_duration').val()))

  get_partial_total = ->
    items_total = window.item_total
    if isNaN(items_total)
      items_total = 0
    accommodation_cost = parseFloat($('#quote_accommodation_total').val())
    program_cost = parseFloat($('#quote_program_total').val())
    insurance_cost = parseFloat($('#quote_insurance_cost').val())
    if isNaN(insurance_cost)
      insurance_cost = 0
    $('#grand-total').val(parseFloat(items_total) + parseFloat(accommodation_cost) + parseFloat(program_cost) + parseFloat(app_total) + insurance_cost)

  quote_week_range = $('#quote_program_week_range').html()
  $('#quote_program_id').on 'change', ->
    quote_program_id = $('#quote_program_id :selected').val()
    quote_program = $('#quote_program_id :selected').text()
    quote_week_options = $(quote_week_range).filter("optgroup[label='#{quote_program}']").html()
    if quote_week_options
      $('#quote_program_week_range').html(quote_week_options)
    else
      $('#quote_program_week_range').empty()


  quote_week_range = $('#quote_program_week_range').html()
  quote_program_id = $('#quote_program_id :selected').val()
  quote_program = $('#quote_program_id :selected').text()
  quote_week_options = $(quote_week_range).filter("optgroup[label='#{quote_program}']").html()
  if quote_week_options
    $('#quote_program_week_range').html(quote_week_options)
  else
    $('#quote_program_week_range').empty()


  ########### end of type of program statements

  ## Total number of hours calculation
  quote_program_id = $('#quote_program_id :selected').val()
  quote_program = $('#quote_program_id :selected').text()
  options = $(quote_week_range).filter("optgroup[label='#{quote_program}']").html()
  if options
    $('#quote_week_program_hours').html(options)
  else
    $('#quote_week_program_hours').empty()
  $('#quote_number_of_hours').on 'focus', ->
    $('#quote_number_of_hours').val(parseInt($('#quote_week_program_hours').text() * $('#weeks').val()))

  $('#quote_program_week_range').on 'change', ->
    try
      $('#ro_quote_program_cost').val(($('#quote_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', '')))
    catch error

    get_program_total()
  #######################################

  ogi2 = (added_item) ->
    try
      precio_viejo = added_item.find('option:selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
    catch
      precio_viejo = 0
    added_item.change ->
      precio_nuevo = added_item.find('option:selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
      app_total -= parseFloat(precio_viejo)
      app_total += parseFloat(precio_nuevo)
      get_app_total()
      added_item.unbind()
      added_item.focus =>
        ogi2(added_item)
      added_item.blur()
  $('#fixed_duration_programs').on 'cocoon:after-insert', (event, app) ->
    item_count++
    item_serialized_index++
    title = app.find('#program_desc :selected')
    added_item = app.find('select');
    try
      precio = title.text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
    catch
      precio = 0
    app_total += parseFloat(precio)
    get_app_total()
    added_item.focus =>
      ogi2(added_item)

  $('#fixed_duration_programs').on 'cocoon:before-remove', (event, app) ->
    item_count--
    title = app.find('#program_desc :selected')
    try
      precio = title.text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
    catch
      precio= 0
    app_total -= parseFloat(precio)
    get_app_total()

  $("#items a.add_fields").
    data("association-insertion-position", 'before').
    data("association-insertion-node", 'this')

  calc_inserted_item = (item) ->
    item.find(".total").focus ->
      quantity = item.find(".item_quantity").val()
      price = item.find(".item_price").val()
      total = parseFloat(item.find(".total").val())
      if isNaN(total)
        total = 0
      total_calc = parseFloat(quantity * price)
      if total isnt total_calc
        window.item_total -= total
        total = total_calc
        window.item_total += total
        item.find(".total").val(total)

  calculate_select_item = (added_item) ->
    try
      precio_viejo = added_item.find('option:selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
    catch
      precio_viejo = 0
    added_item.change ->
      precio_nuevo = added_item.find('option:selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
      if precio_viejo != precio_nuevo
        window.item_total -= parseFloat(precio_viejo)
        window.item_total += parseFloat(precio_nuevo)
      added_item.unbind()
      added_item.focus =>
        calculate_select_item(added_item)
      added_item.blur()
  $('#items').on 'cocoon:after-insert', (e, item) ->
    title = item.find('#item_desc :selected')
    added_item = item.find('select')
    $(".statement-item-fields a.add_fields").
      data("association-insertion-position", 'before').
      data("association-insertion-node", 'this')
    $(this).find('.statement-item-fields').on 'cocoon:after-insert', ->
      console.log('insert new tag ...')
      console.log($(this))
      $(this).children(".item_from_list").remove()
      $(this).children("div").find("a.add_fields").hide()
      try
        precio = title.text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
      catch
        precio = 0
      window.item_total-= parseFloat(precio)
      calc_inserted_item(item)
    try
      precio = title.text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
    catch
      precio = 0
    window.item_total += parseFloat(precio)
    added_item.focus =>
      calculate_select_item(added_item)


  $('#items').on 'cocoon:before-remove', (e, item) ->
    title = item.find('#item_desc :selected')
    try
      precio = title.text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
    catch
      precio= 0
    if isNaN(precio)
      precio = 0
    window.item_total -= parseFloat(precio)
    total = parseFloat(item.find(".total").val())
    if isNaN(total)
      total = 0
    window.item_total -= total

  $('.statement-item-fields').on 'cocoon:before-insert', (e, item) ->
    try
      precio = $(this).find(".item_from_list").text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
    catch
      precio = 0
    window.item_total -= parseFloat(precio)
    console.log('replace OLD tag ...')
    e.stopPropagation()
    console.log($(this))
    $(this).find(".item_from_list").remove()
    $(this).find("a.add_fields").hide()
    calc_inserted_item(item)

  get_app_total = ->
    $('#app_total').val(app_total)

  $('#grand-total').on 'focus', ->
    get_partial_total()

  $('#create-quote').on 'click', ->
    get_program_total()
    get_partial_total()
    $('#quote_post_rebate_program_cost').val((($('#quote_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))))

  ## accommodation functions and variables
  quote_accommodations = $('#quote_accommodation_id').html()
  $('#quote_adulthood_id').on 'change', ->
    quote_adulthood_id = $('#quote_adulthood_id :selected').val()
    quote_adulthood = $('#quote_adulthood_id :selected').text()
    quote_accommodation_options = $(quote_accommodations).filter("optgroup[label='#{quote_adulthood}']").html()
    if quote_accommodation_options
      $('#quote_accommodation_id').html(quote_accommodation_options)
    else
      $('#quote_accommodation_id').empty()
    $('select[name="quote[accommodation_cost]"]').val($('#quote_accommodation_id :selected').val())

  $('#quote_accommodation_id').on 'change', ->
    quote_accommodation_id = $('#quote_accommodation_id').val()
    $('select[name="quote[accommodation_cost]"]').val(quote_accommodation_id)
    get_accommodation_total()


  quote_accommodations = $('#quote_accommodation_id').html()
  quote_adulthood_id = $('#quote_adulthood_id :selected').val()
  quote_adulthood = $('#quote_adulthood_id :selected').text()
  quote_accommodation_options = $(quote_accommodations).filter("optgroup[label='#{quote_adulthood}']").html()
  if quote_accommodation_options
    $('#quote_accommodation_id').html(quote_accommodation_options)
  else
    $('#quote_accommodation_id').empty()
  $('select[name="quote[accommodation_cost]"]').val($('#quote_accommodation_id :selected').val())

  quote_accommodation_id = $('#quote_accommodation_id').val()
  $('select[name="quote[accommodation_cost]"]').val(quote_accommodation_id)
  ########################

  ## promos

  promotions = $('#quote_promo_ids').html()
  $.fn.billing.extract_promos($('#quote_region_id :selected'), promotions, $('#quote_promo_ids'))

  $('#quote_region_id').change ->
    $.fn.billing.extract_promos($('#quote_region_id :selected'), promotions, $('#quote_promo_ids'))

  ## registration fee logic
  registration_fee = () ->
    placement_index = parseInt(item_serialized_index + 1)
    name = "#name_" +  placement_index
    quantity = "#quantity_" +  placement_index
    price = "#precio_" +  placement_index
    $('#add_item_btn').trigger "click"
    $(name).val("Registration fee")
    $(quantity).val(1)
    $(price).val(150)
    $(price).trigger "focus"
    $('.total').trigger "focus"

  registration_fee()

  $('#weeks').on 'input propertychange', ->
    get_program_total()

  $('#quote_program_id').change ->
    get_program_total()

  $('#quote_program_total').focus ->
    get_program_total()

  $('#quote_accommodation_duration').on 'input propertychage', ->
    get_accommodation_total()

  get_program_total()

  get_accommodation_total()

  $('#promo_btn').click ->
    get_program_total()

  app_name = (ok) ->
    title = $("select[name='" + ok + "' ] :selected").html()
    try
      precio = parseFloat(title.match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', ''))
    catch
      precio = 0
    app_total += parseFloat(precio)
    get_app_total()


    try
      previous_precio = $(this).find('option:selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
    catch
      previous_precio = 0
    $(this).change ->
      try
        nuevo_precio = $(this).find('option:selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
      catch
        nuevo_precio = 0
      if previous_precio isnt nuevo_precio
        app_total = app_total - parseFloat(previous_precio)
        app_total = app_total + parseFloat(nuevo_precio)
        previous_precio = $(this).find('option:selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
        get_app_total()

  $('select[id="program_desc"]').map (i) ->
    if ($('select[id="program_desc"]').attr('name').toLowerCase().indexOf("quote") >= 0)
      ok = "quote[fixed_duration_pro_statements_attributes][#{i}][fixed_duration_program_id]"
    else if ($('select[id="program_desc"]').attr('name').toLowerCase().indexOf("pro_forma") >= 0)
      ok = "pro_forma[fixed_duration_pro_statements_attributes][#{i}][fixed_duration_program_id]"
    else if ($('select[id="program_desc"]').attr('name').toLowerCase().indexOf("invoice") >= 0)
      ok = "invoice[fixed_duration_pro_statements_attributes][#{i}][fixed_duration_program_id]"
    app_name.call(this, ok)


  item_name = (ok) ->
    title = $("select[name='" + ok + "' ] :selected").html()
    try
      precio = parseFloat(title.match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', ''))
    catch
      precio = 0
    window.item_total += parseFloat(precio)
    get_app_total()


    try
      previous_precio = $(this).find('option:selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
    catch
      previous_precio = 0
    $(this).change ->
      try
        nuevo_precio = $(this).find('option:selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
      catch
        nuevo_precio = 0
      if previous_precio isnt nuevo_precio
        window.item_total = item_total - parseFloat(previous_precio)
        window.item_total = item_total + parseFloat(nuevo_precio)
        previous_precio = $(this).find('option:selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[1].replace('$', '')
        get_app_total()

  $('select[id="item_desc"]').map (i) ->
    if ($('select[id="item_desc"]').attr('name').toLowerCase().indexOf("quote") >= 0)
      ok = "quote[statement_items_attributes][#{i}][item_id]"
    else if ($('select[id="item_desc"]').attr('name').toLowerCase().indexOf("pro_forma") >= 0)
      ok = "pro_forma[statement_items_attributes][#{i}][item_id]"
    else if ($('select[id="item_desc"]').attr('name').toLowerCase().indexOf("invoice") >= 0)
      ok = "invoice[statement_items_attributes][#{i}][item_id]"
    item_name.call(this, ok)

  student_validator = $('#new_student').validate({
    rules: {
      "student[status]": {required: true}
      "student[first_name]": {required: true}
      "student[last_name]": {required: true}
      "student[date_of_birth]": {required: true}
      "student[age]": {required: true}
      "student[adulthood_id]": {required: true}
      "student[accommodation_id]": {required: true}
      "student[region_id]": {required: true}
      "student[program_cost]": {required: true}
      "student[level]": {required: true}
      "student[start_date]": {required: true}
      "student[end_date]": {required: true}
      "student[program_cost]": {required: true}
      "student[duration_weeks]": {required: true}
      "student[entire_stay_duration]": {required: true}
      "student[accommodation_duration]": {required: true}
      "student[total_hours]": {required: true}
      "student[email_address]": {required: true}
      "student[level]": {required: true}
      "student[insurance]": {required: true}
      "student[caq]": {required: true}
      "student[study_permit]": {required: true}
      "student[airport_transfer]": {required: true}
      "student[visa]": {required: true}
      "student[certificate_issued]": {required: true}
      "student[agency_id]": {required: true}
    }
  })

  quote_validator = $("#new_quote").validate({
    rules: {
      "quote[first_name]": {required: true}
      "quote[last_name]": {required: true}
      "quote[adulthood_id]": {required: true}
      "quote[accommodation_id]": {required: true}
      "quote[region_id]": {required: true}
      "quote[course_language]": {required: true}
      "quote[program_id]": {required: true}
      "quote[program_cost]": {required: true, number:true}
      "quote[start_date]": {required: true}
      "quote[end_date]": {required: true}
      "quote[entire_stay_duration]": {required: true, digits:true}
      "quote[duration_weeks]": {required: true, digits:true}
      "quote[email_address]": {required: true, email:true}
      "quote[date_of_validity]": {required: true}
      "quote[agency_id]": {required: true}
      "quote[total_amount]": {required: true, number:true}
      'quote[promo_ids][]': {
        required: true,
        minlength: 1
      }
    },
    messages: {
      'quote[promo_ids][]': "Please select at least one promo"
    }
  })

  $('#quote_wizard').bootstrapWizard({
    'tabClass': 'nav nav-pills',
    'onNext': (tab, navigation, index) ->
      $valid = $('#new_quote').valid()
      if !$valid
        quote_validator.focusInvalid()
        return false
    'onTabChange': (tab, navigation, index) ->
      $valid = $('#new_quote').valid()
      if !$valid
        quote_validator.focusInvalid()
        return false
    'onTabShow': (tab, navigation, index) ->
      if index != 7
        $('#create-quote').addClass('hidden')
      else
        $('#create-quote').removeClass('hidden')
      $total = navigation.find('li').length
      $current = index+1
      $percent = ($current/$total) * 100
      $('#quote_wizard .progress-bar').css({width:$percent+'%'})
  })

  $('#student_wizard').bootstrapWizard({
    'tabClass': 'nav nav-pills',
    'onNext': (tab, navigation, index) ->
      $valid = $('#new_student').valid()
      if !$valid
        student_validator.focusInvalid()
        return false
    'onTabShow': (tab, navigation, index) ->
      if index != 9
        $('#new_student_submit').addClass('hidden')
      else
        $('#new_student_submit').removeClass('hidden')
      $total = navigation.find('li').length
      $current = index+1
      $percent = ($current/$total) * 100
      $('#student_wizard .progress-bar').css({width:$percent+'%'})
  })

  $('#new_student_wizard').bootstrapWizard({
    'tabClass': 'nav nav-pills',
    'onNext': (tab, navigation, index) ->
      $valid = $('#new_student').valid()
      if !$valid
        student_validator.focusInvalid()
        return false
    'onTabShow': (tab, navigation, index) ->
      if index != 5
        $('#new_student_submit').addClass('hidden')
      else
        $('#new_student_submit').removeClass('hidden')
      $total = navigation.find('li').length
      $current = index+1
      $percent = ($current/$total) * 100
      $('#student_wizard .progress-bar').css({width:$percent+'%'})
    'onTabChange': (tab, navigation, index) ->
      $valid = $('#new_student').valid()
      if !$valid
        student_validator.focusInvalid()
        return false
  })

  if $('.quote-forms').length > 0

    $.when($.fn.billing.get_insurance_total_partial("#quote_insurance_id", 'quote', "#quote_insurance_cover_period")).done ->
      $.fn.billing.update_insurance_total('quote', $('#quote_insurance_cover_period').val())

    $.fn.billing.update_insurance_cost('quote')

    for date in $('input[id*=date_accommodation]')
      $.fn.billing.automate_date_picking(date, '#quote_start_date_accommodation', '#quote_end_date_accommodation',
        '#quote_accommodation_duration', get_accommodation_total)

    for date in $('input[id*=date_insurance]')
      $.fn.billing.automate_date_picking(date, '#quote_start_date_insurance', '#quote_end_date_insurance',
        '#quote_insurance_cover_period', $.fn.billing.update_insurance_total, 'quote')
