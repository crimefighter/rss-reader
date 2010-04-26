$(document).ready(function() {
  $(".add_feed_toggle").click(function() {
    $(this).next("#new_feed").toggle();
    return false;
  });

  $("h2.header a").keynav();
});
