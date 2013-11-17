jQuery ->
  $(".request-btn").hide()
  $(".proposal").hover(
    -> $(this).find(".request-btn").fadeIn(40),
    -> $(this).find(".request-btn").fadeOut(10))
