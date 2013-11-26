jQuery ->
  $(".request-btn").hide()
  $(".proposal").hover(
    -> $(this).find(".request-btn").fadeIn(40),
    -> $(this).find(".request-btn").fadeOut(10))

jQuery ->
  $(".request-btn").click(->
    if $("#sign_out").length > 0
      index = $(this).index(".request-btn")
      $(".request").eq(index).toggleClass("hidden")
  )
