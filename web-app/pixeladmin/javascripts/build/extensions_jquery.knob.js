(function() {
  var knob;

  if (!$.fn.knob) {
    throw new Error('jquery.knob.js required');
  }

  knob = $.fn.knob;

  $.fn.knob = function(o) {
    var $body;
    $body = $('body');
    return knob.call(this, o).each(function() {
      var $input;
      if ($body.hasClass('right-to-left')) {
        $input = $(this).find('input');
        return $input.css({
          'margin-left': 0,
          'margin-right': $input.css('margin-left')
        });
      }
    });
  };

}).call(this);
