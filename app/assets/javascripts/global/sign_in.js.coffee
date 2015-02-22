jQuery ->
  $(".js-sign-in-btn").on 'click', (e)->
    e.preventDefault()

    # prevent focus on the first item in the dialog
    $.ui.dialog.prototype._focusTabbable = ->
      undefined

    $("#dialog").dialog
      modal: true
      width: 600
      position: ['top', 150]
