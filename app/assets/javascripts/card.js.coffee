jQuery ->
  $(".request-btn").hide()
  $(".proposal").hover(
    -> $(this).find(".request-btn").fadeIn(),
    -> $(this).find(".request-btn").fadeOut())
