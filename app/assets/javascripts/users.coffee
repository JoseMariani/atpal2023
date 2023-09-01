$ ->

  $('#user_agency_ids').multiselect();

  filterAgencyMenu = ->
    if $('#user_role').find(":selected").text() != 'admin'
      $('.restricted_agencies').removeClass('hidden')
    else
      $('.restricted_agencies').addClass('hidden')

  filterAgencyMenu()

  $('#user_role').on 'input propertychange', ->
    filterAgencyMenu()