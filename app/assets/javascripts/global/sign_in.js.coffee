jQuery ->
  $(".sign-in-btn").on('click', (e)->
    e.preventDefault()

    # prevent focus on the first item in the dialog
    $.ui.dialog.prototype._focusTabbable = ->
      undefined

    target = $(".sign-in-btn")
    $("#dialog").dialog(
      position:
        my: 'center top'
        at: 'center bottom'
        of: target
    )
  )
