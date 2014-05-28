(function() {
  var datepicker;

  if (!$.fn.datepicker) {
    throw new Error('bootstrap-datepicker.js required');
  }

  datepicker = $.fn.datepicker;

  $.fn.datepicker = function(options) {
    options = $.extend({
      rtl: $('body').hasClass('right-to-left')
    }, options || {});
    return datepicker.call($(this), options);
  };

}).call(this);
