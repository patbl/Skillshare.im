jQuery ->
  $(".sign-in-btn").on('click', (e)->
    e.preventDefault()
    target = $(".sign-in-btn")
    $("#dialog").dialog(
      position:
        my: 'center top'
        at: 'center bottom'
        of: target
    )
  )
