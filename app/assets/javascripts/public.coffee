$(document).on "page:fetch", ->
  $(".content").hide()
  $(".spinner").show()

$(document).on "page:receive", ->
  $(".spinner").hide()
  $(".content").show()