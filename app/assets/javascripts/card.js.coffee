jQuery ->
  $(".offer-btn").hide()
  $(".proposal").hover(
    -> $(this).find(".offer-btn").fadeIn(40),
    -> $(this).find(".offer-btn").fadeOut(10))

jQuery ->
  $(".request-btn").click(->
    if $("#sign_out").length > 0
      index = $(this).parents(".proposal")
      $(index).find(".request").toggleClass("hidden")
  )
