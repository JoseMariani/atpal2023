$ ->
  $('#notes-link').click ->
    alert('ogi')

  $('.auto-text-area').keyup ->
    $(this).css('height', 'auto')
    $(this).css('word-wrap', 'break-word')
    $(this).height(this.scrollHeight)