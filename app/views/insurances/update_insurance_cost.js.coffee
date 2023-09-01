$("#<%= @billing_type %>_insurance_cost_per_week").empty()
  .append("<%= escape_javascript(render(:partial => 'insurances/insurance_option', insurance: @insurance)) %>")