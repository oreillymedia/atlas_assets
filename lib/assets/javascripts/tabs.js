$(function() {
  var makeActive = function ($el) {
    $el.addClass('active').siblings().removeClass('active');
  }

  var showTab = function ($el) {
    target = $($el.data().target);
    makeActive($el);
    makeActive(target);
  }


  hz_tabs = $('.tabs.horizontal li')
  hz_tabs.css('width', (1/hz_tabs.length * 100)+"%");

  $('.tabs .tab-anchor').click(function (e) {
    // don't do anything if the click was in an input
    if (e.target.tagName === "INPUT") {
      e.stopPropagation();
    } else {
      e.preventDefault();
      showTab($(this));
    }
  });
});