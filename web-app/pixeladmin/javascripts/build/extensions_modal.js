(function() {
  var $Vague, blurOff, blurOn, modal_hide, modal_show, _blurred;

  if (!$.fn.modal || !$.fn.Vague || !$('html').hasClass('not-ie')) {
    return;
  }

  modal_show = $.fn.modal.Constructor.prototype.show;

  modal_hide = $.fn.modal.Constructor.prototype.hide;

  $Vague = null;

  _blurred = false;

  blurOn = function() {
    if (_blurred) {
      return;
    }
    if (!$Vague) {
      $Vague = $('#main-wrapper').Vague({
        intensity: 3,
        forceSVGUrl: false
      });
    }
    $Vague.blur();
    return _blurred = true;
  };

  blurOff = function() {
    if (!_blurred) {
      return;
    }
    if ($Vague) {
      $Vague.unblur();
    }
    return _blurred = false;
  };

  $.fn.modal.Constructor.prototype.show = function() {
    modal_show.call(this);
    if (this.$element.hasClass('modal-blur')) {
      $('body').append(this.$element);
      if (getScreenSize($('#small-screen-width-point'), $('#tablet-screen-width-point')) === 'desktop') {
        blurOn();
      }
      return $(window).on('pa.resize.modal_blur', function() {
        if (getScreenSize($('#small-screen-width-point'), $('#tablet-screen-width-point')) === 'desktop') {
          return blurOn();
        } else {
          return blurOff();
        }
      });
    } else {
      return blurOff();
    }
  };

  $.fn.modal.Constructor.prototype.hide = function() {
    modal_hide.call(this);
    blurOff();
    return $(window).off('pa.resize.modal_blur').on('hidden', '.modal', function() {
      return alert('asd');
    });
  };

}).call(this);
