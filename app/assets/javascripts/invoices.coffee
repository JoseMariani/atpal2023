$ ->

#variables
  item_count = 0
  payment_count = 0
  payment_serialized_index = 0
  placement_index = 0
  global_balance = $('#invoice_balance').val()
  balance = $('#invoice_balance')
  invoice_grand_total = $('#invoice_grand_total')
  program_week_range = $('#invoice_program_week_range')
  program_total = $('#invoice_program_total')
  program_id = $('#invoice_program_id')
  read_only_weeks = $('#ro_invoice_weeks')
  read_only_program_cost = $('#ro_invoice_program_cost')
  accommodation_total = $('#invoice_accommodation_total')
  accommodation_duration = $('#invoice_accommodation_duration')
  read_only_accommodation_cost = $('#ro_invoice_accommodation_cost')

  weeks = $("#weeks")

  #functions

  ## execute this for invoice only
  try
    read_only_program_cost.val(program_week_range_selected.text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))
    console.log(read_only_program_cost.val())
  catch error


  read_only_weeks.val(weeks.val())
  program_total.val((read_only_program_cost.val() * read_only_weeks.val()).toFixed(2))
  accommodation_total.val(parseFloat($('select[name="invoice[accommodation_cost]"]').val($('#invoice_accommodation_id :selected').text()) * accommodation_duration.val()).toFixed(2))

  get_program_total = ->
    try
      read_only_program_cost.val($('#invoice_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))
      console.log(read_only_program_cost.val())
    catch error

    if $('#invoice_promo_ids :selected').text() != ""
      invoice_promos_prct = $.fn.billing.get_promos($('#invoice_promo_ids :selected'))
      invoice_local_program_total = $('#invoice_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', '')
      for i in [0..invoice_promos_prct.length-1]
        read_only_program_cost.val($.fn.billing.get_temporary_program_cost(invoice_local_program_total, invoice_promos_prct[i]))
        console.log(read_only_program_cost.val())
        invoice_local_program_total = read_only_program_cost.val()
    read_only_weeks.val(weeks.val())
    program_total.val(parseFloat(read_only_program_cost.val() * read_only_weeks.val()).toFixed(2))

  get_accommodation_total = ->
    read_only_accommodation_cost.val($('#invoice_accommodation_cost :selected').text())
    accommodation_total.val(parseFloat(read_only_accommodation_cost.val() *
        accommodation_duration.val()).toFixed(2))

  get_partial_total = ->
    invoice_items_total = window.item_total
    if isNaN(invoice_items_total)
      invoice_items_total = 0
    invoice_app_total = $('#app_total').val()
    if isNaN(invoice_app_total) || !invoice_app_total? || invoice_app_total == ""
      invoice_app_total = 0
    invoice_insurance_cost = parseFloat($('#invoice_insurance_cost').val())
    if isNaN(invoice_insurance_cost) || !invoice_insurance_cost? || invoice_insurance_cost == ""
      invoice_insurance_cost = 0
    invoice_accommodation_cost = parseFloat(accommodation_total.val())
    invoice_program_cost = parseFloat(program_total.val())
    invoice_grand_total.val((parseFloat(invoice_items_total) + parseFloat(invoice_accommodation_cost) + parseFloat(invoice_program_cost) + parseFloat(invoice_app_total) + invoice_insurance_cost).toFixed(2))

  invoice_hours = program_week_range.html()
  program_id.on 'change', ->
    invoice_program_id = $('#invoice_program_id :selected').val()
    invoice_program = $('#invoice_program_id :selected').text()
    invoice_options = $(invoice_hours).filter("optgroup[label='#{invoice_program}']").html()
    if invoice_options
      program_week_range.html(invoice_options)
    else
      program_week_range.empty()
    $('select[name="invoice[program_cost]"]').val(invoice_program_id)

  invoice_hours = program_week_range.html()
  invoice_program_id = $('#invoice_program_id :selected').val()
  invoice_program = $('#invoice_program_id :selected').text()
  invoice_options = $(invoice_hours).filter("optgroup[label='#{invoice_program}']").html()
  if invoice_options
    program_week_range.html(invoice_options)
  else
    program_week_range.empty()
  $('select[name="invoice[program_cost]"]').val(invoice_program_id)


  program_week_range.on 'change', ->
    try
      read_only_program_cost.val($('#invoice_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))
    catch error


    get_program_total()
  ########### end of type of program statements

  ## Total number of hours calculation
  invoice_program_id = $('#invoice_program_id :selected').val()
  invoice_program = $('#invoice_program_id :selected').text()
  invoice_options = $(invoice_hours).filter("optgroup[label='#{invoice_program}']").html()
  if invoice_options
    $('#invoice_week_program_hours').html(invoice_options)
  else
    $('#invoice_week_program_hours').empty()
  #######################################

  $('#payments').on 'cocoon:after-insert', (event) ->
    payment_count++
    payment_serialized_index++
    date = $('.nested-fields').find("#payment_date").attr id: "payment_date_" + payment_serialized_index
    payment = $('.nested-fields').find("#payment_amount").attr id: "payment_amount_" + payment_serialized_index
    for i in [1..payment_serialized_index]
      $('body').delegate '#payment_date_'+i, "focusin", (evt)->
        $(this).datepicker({ dateFormat: 'dd-mm-yy', changeYear: true, changeMonth: true, minDate: "0Y", maxDate: "3Y"})


  $('#payments').on 'cocoon:before-remove', (event) ->
    payment_count--
    date = $('.nested-fields').find("#payment_date").attr id: "payment_date_" + payment_serialized_index
    payment = $('.nested-fields').find("#payment_amount").attr id: "payment_amount_" + payment_serialized_index
    date.val("")
    payment.val(0)

  invoice_grand_total.on 'focus', ->
    get_partial_total()

  $('#create-invoice').on 'click', ->
    get_program_total()
    get_partial_total()
    $.fn.billing.invoice.get_balance(global_balance, payment_serialized_index, $('.nested-fields'), balance, invoice_grand_total)
    $('#invoice_post_rebate_program_cost').val($('#invoice_program_week_range :selected').text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))

  ## promos

  promotions = $('#invoice_promo_ids').html()
  $.fn.billing.extract_promos($('#invoice_region_id :selected'), promotions, $('#invoice_promo_ids'))

  $('#invoice_region_id').change ->
    $.fn.billing.extract_promos($('#invoice_region_id :selected'), promotions, $('#invoice_promo_ids'))

  ## accommodation functions and variables
  invoice_accommodations = $('#invoice_accommodation_id').html()
  $('#invoice_adulthood_id').on 'change', ->
    invoice_adulthood_id = $('#invoice_adulthood_id :selected').val()
    invoice_adulthood = $('#invoice_adulthood_id :selected').text()
    invoice_accommodation_options = $(invoice_accommodations).filter("optgroup[label='#{invoice_adulthood}']").html()
    if invoice_accommodation_options
      $('#invoice_accommodation_id').html(invoice_accommodation_options)
    else
      $('#invoice_accommodation_id').empty()
    $('select[name="invoice[accommodation_cost]"]').val($('#invoice_accommodation_id :selected').val())

  $('#invoice_accommodation_id').on 'change', ->
    invoice_accommodation_id = $('#invoice_accommodation_id').val()
    $('select[name="invoice[accommodation_cost]"]').val(invoice_accommodation_id)
    get_accommodation_total()


  invoice_accommodations = $('#invoice_accommodation_id').html()
  invoice_adulthood_id = $('#invoice_adulthood_id :selected').val()
  invoice_adulthood = $('#invoice_adulthood_id :selected').text()
  invoice_accommodation_options = $(invoice_accommodations).filter("optgroup[label='#{invoice_adulthood}']").html()
  if invoice_accommodation_options
    $('#invoice_accommodation_id').html(invoice_accommodation_options)
  else
    $('#invoice_accommodation_id').empty()
  $('select[name="invoice[accommodation_cost]"]').val($('#invoice_accommodation_id :selected').val())

  invoice_accommodation_id = $('#invoice_accommodation_id').val()
  $('select[name="invoice[accommodation_cost]"]').val(invoice_accommodation_id)
  ########################

  weeks.on 'input propertychange', ->
    get_program_total()

  program_id.change ->
    get_program_total()

  program_total.focus ->
    get_program_total()

  accommodation_duration.on 'input propertychage', ->
    get_accommodation_total()

  get_program_total()

  get_accommodation_total()

  $('#promo_btn').click ->
    get_program_total()

  $('body').delegate '#payment_amount', "change", (evt)->
    $.fn.billing.invoice.get_balance(global_balance, payment_serialized_index, $('.nested-fields'), balance, invoice_grand_total)

  $('#invoice_balance').click ->
    $.fn.billing.invoice.get_balance(global_balance, payment_serialized_index, $('.nested-fields'), balance, invoice_grand_total)

  $('#balance').click ->
    balance.val(global_balance)

  $invoice_validator = $('#new_invoice').validate({
    rules: {
      "invoice[first_name]": {required: true}
      "invoice[last_name]": {required: true}
      "invoice[adulthood_id]": {required: true}
      "invoice[accommodation_id]": {required: true}
      "invoice[region_id]": {required: true}
      "invoice[course_language]": {required: true}
      "invoice[program_id]": {required: true}
      "invoice[week_program_hours]": {required: true, digits:true}
      "invoice[program_cost]": {required: true, number:true}
      "invoice[start_date]": {required: true}
      "invoice[end_date]": {required: true}
      "invoice[entire_stay_duration]": {required: true, digits:true}
      "invoice[duration_weeks]": {required: true, digits:true}
      "invoice[email_address]": {required: true}
      "invoice[balance]": {required: true, number:true}
      "invoice[total_amount]": {number: true}
      "invoice[agency_id]": {required: true}
      'invoice[promo_ids][]': {
        required: true,
        minlength: 1
      }
    },
    messages: {
      'invoice[promo_ids][]': "Please select at least one promo"
    }
  })

  $('#invoice_wizard').bootstrapWizard({
    'tabClass': 'nav nav-pills',
    'onNext': (tab, navigation, index) ->
      $valid = $("#new_invoice").valid()
      if !$valid
        $invoice_validator.focusInvalid()
        return false
    'onTabShow': (tab, navigation, index) ->
      if index != 8
        $('#create-invoice').addClass('hidden')
      else
        $('#create-invoice').removeClass('hidden')
      $total = navigation.find('li').length
      $current = index+1
      $percent = ($current/$total) * 100
      $('#invoice_wizard .progress-bar').css({width:$percent+'%'})
    'onTabChange': (tab, navigation, index) ->
      $valid = $('#new_invoice').valid()
      if !$valid
        $invoice_validator.focusInvalid()
        return false
  })

  if $('.invoice-forms').length > 0

    $.when($.fn.billing.get_insurance_total_partial("#invoice_insurance_id", 'invoice', "#invoice_insurance_cover_period")).done ->
      $.fn.billing.update_insurance_total('invoice', $('#invoice_insurance_cover_period').val())

    $.fn.billing.update_insurance_cost('invoice')

    for date in $('input[id*=date_accommodation]')
      $.fn.billing.automate_date_picking(date, '#invoice_start_date_accommodation', '#invoice_end_date_accommodation',
        '#invoice_accommodation_duration', get_accommodation_total)

    for date in $('input[id*=date_insurance]')
      $.fn.billing.automate_date_picking(date, '#invoice_start_date_insurance', '#invoice_end_date_insurance',
        '#invoice_insurance_cover_period', $.fn.billing.update_insurance_total, 'invoice')
