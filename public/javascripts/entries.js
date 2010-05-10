$(document).ready(function() {
  $("#add_subscription").dialog({
  });
  $(".add_feed_toggle").click(function() {
    $("#add_subscription").dialog('open');
    return false;
  });

  $("div.feed_properties").each(function() {
    feed_name = $(this).parent().find("a.feed").html();
    $open_link = $(this).prev("a.feed_menu_icon");
    var that = $(this);
    that.dialog({
      title: feed_name + " properties",
      autoOpen: false,
      resizeable: false,
      modal: true,
      hight: 300,
      width: 400
    });
    $open_link.click(function() {
      that.dialog('open');
    });
  });

  $("ul#feeds li").bind("mouseenter", function() {
    $(this).find(".feed_menu_icon").show();
  }).bind("mouseleave", function() {
    $(this).find(".feed_menu_icon").hide();
  });

  $("h2.header a").keynav();
});
