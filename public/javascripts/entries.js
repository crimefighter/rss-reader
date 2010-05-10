$(document).ready(function() {
  $("#add_subscription").dialog({
    title: "Subscribe to a feed...",
    autoOpen: false,
    modal: true,
    resizable: false,
    position: [20,40],
    width: 400
  });
  $(".add_feed_toggle").click(function() {
    $("#add_subscription").dialog('open');
    $("#feed_url").focus();
    return false;
  });

  $("div.feed_properties").each(function() {
    feed_name = $(this).parent().find("a.feed").html();
    $open_link = $(this).prev("a.feed_menu_icon");
    var that = $(this);
    that.dialog({
      title: feed_name + " properties",
      autoOpen: false,
      resizable: false,
      modal: true,
      width: 400,
      position: 'center'
    });
    $open_link.click(function() {
      that.dialog('open');
      return false;
    });
  });

  $("ul#feeds li").bind("mouseenter", function() {
    $(this).find(".feed_menu_icon").show();
  }).bind("mouseleave", function() {
    $(this).find(".feed_menu_icon").hide();
  });

  $("h2.header a").keynav();
});
