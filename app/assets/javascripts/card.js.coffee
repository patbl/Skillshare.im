jQuery ->
  $(".proposal-btn").hide()
  $(".proposal").hover(
    -> $(this).find(".proposal-btn").fadeIn(40),
    -> $(this).find(".proposal-btn").fadeOut(10))

jQuery ->
  $(".request-btn").click(->
    if $("#sign_out").length > 0
      index = $(this).parent().parent().parent().parent().parent()
      $(index).find(".request").toggleClass("hidden")
  )
