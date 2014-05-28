(function() {
  var datepaginator;

  if (!$.fn.datepaginator) {
    throw new Error('bootstrap-datepaginator.js required');
  }

  datepaginator = $.fn.datepaginator;

  $.fn.datepaginator = function(options, args) {
    return datepaginator.call(this, $.extend({}, {
      injectStyle: false,
      itemWidth: 45,
      selectedItemWidth: 160
    }, options || {}), args);
  };

}).call(this);
