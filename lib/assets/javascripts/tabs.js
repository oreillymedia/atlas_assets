$(function() {
  var makeActive = function ($el) {
    $el.addClass('active').siblings().removeClass('active');
  }

  var showTab = function ($el) {
    target = $($el.data().target);
    makeActive($el);
    makeActive(target);
  }

  $('.tabs .tab-anchor').click(function (e) {
    // don't do anything if the click was in a
    if (e.target.tagName === "INPUT") {
      e.stopPropagation();
    } else {
      e.preventDefault();
      showTab($(this));
    }
  });
});