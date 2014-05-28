(function() {
  var getBarWidth;

  if (!$.fn.sparkline) {
    throw new Error('jquery.sparkline.js required');
  }

  getBarWidth = function($el, count, space) {
    var s, w;
    w = $el.outerWidth();
    s = parseInt(space) * (count - 1);
    return Math.floor((w - s) / count);
  };

  $.fn.pixelSparkline = function() {
    var bars_space, f_args, is_bars, vals_count;
    f_args = arguments;
    is_bars = false;
    vals_count = 0;
    bars_space = '2px';
    if (f_args[0] instanceof Array && f_args[1] instanceof Object && f_args[1].type === 'bar' && f_args[1].width === '100%') {
      is_bars = true;
      vals_count = f_args[0].length;
      if (f_args[1].barSpacing) {
        bars_space = f_args[1].barSpacing;
      }
      f_args[1].barWidth = getBarWidth($(this), vals_count, bars_space);
    }
    $.fn.sparkline.apply(this, f_args);
    return $(window).on('pa.resize', (function(_this) {
      return function() {
        if (is_bars) {
          f_args[1].barWidth = getBarWidth($(_this), vals_count, bars_space);
        }
        return $.fn.sparkline.apply(_this, f_args);
      };
    })(this));
  };

}).call(this);
