$(document).ready(function() {

  $(window).resize(function() {
    $("ul#feeds").width($(window).width() - $("ul#entries").width() - 40);
  });
  $(window).resize();

  $(window).scroll(function() {
    if(isReallyVisible("h1#logo")) {
      $("ul#feeds").css("top", "50px");
    } else {
      $("ul#feeds").css("top", "10px");
    }
  });

  $(window).infinitescroll({
    url: window.location.href,
    appendTo: "ul#entries"
  });

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
    $feed_link = $(this).parent().find("a.feed");
    feed_name = $feed_link.html();
    $open_link = $(this).prev("a.feed_menu_icon");
    var that = $(this);
    $open_link.qtip({
      content: that.html(),
      position: { 
        corner: { tooltip: 'topMiddle' },
        adjust: { x: -130 }
      },
      style: { 
        tip: true,
        name: 'green', 
        border: { radius: 5, color: '#1862d2' }, 
        background: '#fff', 
        'font-size': '12px' },
      show: { when: { event: 'click' }, delay: 0 },
      hide: { when: { event: 'unfocus' } }
    });
  });

  $("ul#feeds li").bind("mouseenter", function() {
    $(this).find(".feed_menu_icon").show();
  }).bind("mouseleave", function() {
    $(this).find(".feed_menu_icon").hide();
  });

  $("ul#feeds li div.pagination a").live("click", function() {
    $("ul#feeds span#feed_list").load($(this).attr("href"));
    return false;
  });

  $("ul#tags li.all_tags a").click(function() {
    $tag_cloud = $("ul#entries li.tag_cloud");
    if($tag_cloud.is(':hidden')) {
      $tag_cloud.slideDown();
    } else {
      $tag_cloud.slideUp();
    }
    other_label = $(this).attr("data-other-label");
    $(this).attr("data-other-label", $(this).html());
    $(this).html(other_label);
    $(this).parent().toggleClass("opened");
  });

  //$("h2.header a").keynav();
});

function isReallyVisible(elem) {
  var docViewTop = $(window).scrollTop();
  var docViewBottom = docViewTop + $(window).height();

  var elemTop = $(elem).offset().top;
  var elemBottom = elemTop + $(elem).height();

  return ((elemBottom >= docViewTop) && (elemTop <= docViewBottom));
}
