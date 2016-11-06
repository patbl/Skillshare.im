jQuery(function() {
  $(".proposal-btn").hide();
  return $(".proposal").hover(
    function() { return $(this).find(".proposal-btn").fadeIn(40); },
    function() { return $(this).find(".proposal-btn").fadeOut(10); });
});

jQuery(() =>
  $(".request-btn").click(function() {
    if ($("#sign_out").length > 0) {
      let index = $(this).parents(".proposal");
      return $(index).find(".request").toggleClass("hidden");
    }
  })
);
