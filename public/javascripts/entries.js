$(document).ready(function() {
  $("a.add_feed_toggle").qtip({
    content: $("#add_subscription"),
    position: { corner: { tooltip: 'topLeft' } },
    style: { 
      tip: true,
      name: 'green', 
      border: { radius: 5 }, 
      background: '#fff', 
      width: 400,
      'font-size': '12px' },
    show: { when: { event: 'click' }, delay: 0 },
    hide: { when: { event: 'unfocus' } }
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
