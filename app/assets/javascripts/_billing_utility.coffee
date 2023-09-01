$.fn.billing = {}

$.fn.billing.update_insurance_cost = (type_of_billing) ->
  insurance_type_id = "##{type_of_billing}_insurance_id"
  insurance_period = $("##{type_of_billing}_insurance_cover_period")
  $(insurance_type_id).on 'change', ->
    $.fn.billing.get_insurance_total_partial(insurance_type_id, type_of_billing, insurance_period)
  $(insurance_period).on 'input propertychange', ->
    $.fn.billing.update_insurance_total(type_of_billing, $(this).val())

$.fn.billing.update_insurance_total = (type_of_billing, number_of_weeks) ->
  element = "##{type_of_billing}_insurance_cost"
  insurance_cost_per_week = $( "##{type_of_billing}_insurance_cost_per_week" ).prop('selected', true).val()
  $(element).val($.fn.billing.multiply(parseInt(number_of_weeks), insurance_cost_per_week))

$.fn.billing.multiply = (val1, val2) ->
  total = (val1 * parseFloat(val2)).toFixed(2)
  if isNaN(total) then 0 else total

$.fn.billing.get_temporary_program_cost = (program_cost, promotion_prcnt) ->
  if promotion_prcnt == 0.30 || promotion_prcnt == 0.15
    if parseInt(program_cost) == 390
      return Math.floor((program_cost*(1-promotion_prcnt))/5)*5
    else
      return Math.round((program_cost*(1-promotion_prcnt))/5)*5
  else if promotion_prcnt == 0.25
    if parseInt(program_cost) == 390 || parseInt(program_cost) == 370
      return Math.floor((program_cost*(1-promotion_prcnt))/5)*5
    else
      return Math.round((program_cost*(1-promotion_prcnt))/5)*5
  else if promotion_prcnt == 0.20
    if parseInt(program_cost) == 390
      return Math.floor((program_cost*(1-promotion_prcnt))/5)*5
    else if parseInt(program_cost) == 355
      return Math.round(program_cost*(1-promotion_prcnt))
    else if parseInt(program_cost) == 335
      return Math.ceil((program_cost*(1-promotion_prcnt))+7)
    else
      return Math.round((program_cost*(1-promotion_prcnt))/5)*5
  else
    return Math.round(program_cost*(1-promotion_prcnt))

$.fn.billing.get_insurance_total_partial = (insurance_type_id, type_of_billing, insurance_period) ->
  id = $(insurance_type_id).prop('selected', true).val()
  if id? and id != ""
    $.ajax "/insurances/#{id}/update_insurance_cost",
      type: 'GET'
      dataType: 'script'
      data: {
        billing_type: "#{type_of_billing}"
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        $.fn.billing.update_insurance_total(type_of_billing, $(insurance_period).val())
  else
    $.fn.billing.clear_insurance_fields(type_of_billing)

$.fn.billing.clear_insurance_fields = (type_of_billing) ->
  insurance_type_id = "##{type_of_billing}_insurance_id"
  insurance_cost_per_week = $( "##{type_of_billing}_insurance_cost_per_week" )
  total = "##{type_of_billing}_insurance_cost"

  $(insurance_type_id).prop('selected', false)
  insurance_cost_per_week.empty()
  $(total).val('')

$.fn.billing.get_promos = (selected_promos) ->
  promo_percentages = []
  for promo in selected_promos
    promo_percentages.push($(promo).data('percentage')/100)
  return promo_percentages

$.fn.billing.extract_promos = (selected_regions, promotions, promo_ids) ->
  region = selected_regions.text()
  options = $(promotions).filter("optgroup[label='#{region}']").html()
  if options
    promo_ids.html(options)
  else
    promo_ids.empty()

$.fn.billing.invoice = {}

$.fn.billing.invoice.get_balance = (global_balance, payment_serialized_index, nested_fields, invoice_balance, invoice_grand_total) ->
  balance = global_balance
  if balance > 0
    payments = 0
    for i in [1..payment_serialized_index]
      if isNaN(parseFloat($(nested_fields).find('#payment_amount_'+i).val()))
        payments += 0
      else
        payments += parseFloat($(nested_fields).find('#payment_amount_'+i).val())
    if isNaN(payments)
      $(invoice_balance).val(balance)
    else
      $(invoice_balance).val(balance - payments)
  else
    payments = 0
    for i in [1..payment_serialized_index]
      if isNaN(parseFloat($(nested_fields).find('#payment_amount_'+i).val()))
        payments += 0
      else
        payments += parseFloat($(nested_fields).find('#payment_amount_'+i).val())
    if isNaN(payments)
      payments = 0
    $(invoice_balance).val($(invoice_grand_total).val() - payments)

$.fn.billing.get_program_total = (program_cost, selected_week_range, selected_promos, read_only_weeks, weeks, program_total) ->

  try
    $(program_cost).val($(selected_week_range).text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', ''))
  catch error

  if $(selected_promos).text() != ""
    invoice_promos_prct = $.fn.billing.get_promos($(selected_promos))
    invoice_local_program_total = $(selected_week_range).text().match(/\s\$([0-9]+\.[0-9][0-9]?)/g)[0].replace('$', '')

    for i in [0..invoice_promos_prct.length-1]
      $(program_cost).val(invoice_local_program_total - (invoice_local_program_total * invoice_promos_prct[i]))
      invoice_local_program_total = $(program_cost).val()
  $(read_only_weeks).val($(weeks).val())
  $(program_total).val(parseFloat($(program_cost).val() * $(read_only_weeks).val()))

$.fn.billing.get_accommodation_total = (accommodation_cost, accommodation_selected, accommodation_total, accommodation_duration) ->
  accommodation_cost.val(accommodation_selected.text())
  accommodation_total.val(parseFloat(accommodation_cost.val() *
    accommodation_duration.val()))

$.fn.billing.automate_date_picking = (date_field, start_date, end_date, total_weeks, callback, billing_type) ->

  $(start_date).datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true

  $(end_date).datepicker
    dateFormat: 'yy-mm-dd'
    changeYear: true
    changeMonth: true

  $(date_field).on 'change', ->
    weekfrom = $(start_date).datepicker('getDate')
    weekto = $(end_date).datepicker('getDate')
    totalWeeks = moment(weekto).businessDiff(moment(weekfrom))
    if totalWeeks && isNaN(totalWeeks)?
      $(total_weeks).val(totalWeeks)
      if billing_type?
        callback(billing_type, totalWeeks)
      else
        callback()
