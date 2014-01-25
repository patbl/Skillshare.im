jQuery ->
  $(".sign-in-btn").on('click', (e)->
    e.preventDefault()
    $("#dialog").dialog();
  )
