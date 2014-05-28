
/*
 * @class Limiter
 */

(function() {
  var Limiter;

  Limiter = function($el, limit, options) {
    if (options == null) {
      options = {};
    }
    this.limit = limit;
    this.$el = $el;
    this.options = $.extend({}, Limiter.DEFAULTS, options || {});
    this.$label = this.options.label && $(this.options.label).length ? $('.limiter-count', this.options.label) : null;
    this.textarea = this.$el.is('textarea');
    if (!this.textarea) {
      this.$el.attr('maxlength', this.limit);
    }
    this.$el.on("keyup focus", $.proxy(this.updateCounter, this));
    return this.updateCounter();
  };

  Limiter.prototype.updateCounter = function() {
    var chars_count, input_value;
    input_value = this.textarea ? this.$el[0].value.replace(/\r?\n/g, "\n") : this.$el.val();
    chars_count = input_value.length;
    if (chars_count > this.limit) {
      this.$el.val(input_value.substr(0, this.limit));
      chars_count = this.limit;
    }
    if (this.$label) {
      return this.$label.html(this.limit - chars_count);
    }
  };

  Limiter.DEFAULTS = {
    label: null
  };

  $.fn.limiter = function(limit, options) {
    return this.each(function() {
      var $this;
      $this = $(this);
      if (!$this.attr('data-limiter')) {
        return $.data($this, 'limiter', new Limiter($this, limit, options));
      }
    });
  };

  $.fn.limiter.Constructor = Limiter;

}).call(this);
