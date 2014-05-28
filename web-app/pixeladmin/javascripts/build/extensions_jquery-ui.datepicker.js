(function() {
  var datepicker;

  if (!window.JQUERY_UI_EXTRAS_LOADED || !$.fn.datepicker) {
    throw new Error('jquery.ui.datepicker.js required');
  }

  datepicker = $.fn.datepicker;

  $.fn.datepicker = function(options) {
    return datepicker.call(this, $.extend({
      isRTL: $('body').hasClass('right-to-left')
    }, options || {}));
  };

}).call(this);
