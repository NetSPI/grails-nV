
/*
 * @class ExpandingInput
 */

(function() {
  var ExpandingInput;

  ExpandingInput = function($container, options) {
    if (options == null) {
      options = {};
    }
    this.options = $.extend({}, ExpandingInput.DEFAULTS, options || {});
    this.$container = $container;
    this.$target = this.options.target && this.$container.find(this.options.target).length ? this.$container.find(this.options.target) : null;
    this.$content = this.options.hidden_content && this.$container.find(this.options.hidden_content).length ? this.$container.find(this.options.hidden_content) : null;
    this.$container.addClass('expanding-input');
    if (this.$target) {
      this.$target.addClass('expanding-input-target');
      if (this.$target.hasClass('input-sm')) {
        this.$container.addClass('expanding-input-sm');
      }
      if (this.$target.hasClass('input-lg')) {
        this.$container.addClass('expanding-input-lg');
      }
    }
    if (this.$content) {
      this.$content.addClass('expanding-input-content');
    }
    this.$overlay = $('<div class="expanding-input-overlay"></div>').appendTo(this.$container);
    if (this.$target && this.$target.attr('placeholder')) {
      if (!this.options.placeholder) {
        this.options.placeholder = this.$target.attr('placeholder');
      }
      this.$target.attr('placeholder', '');
    }
    if (this.options.placeholder) {
      this.$overlay.append($('<div class="expanding-input-placeholder"></div>').html(this.options.placeholder));
    }
    if (this.$target) {
      this.$target.on('focus', $.proxy(this.expand, this));
    }
    return this.$overlay.on('click.expanding_input', $.proxy(this.expand, this));
  };

  ExpandingInput.prototype.expand = function() {
    if (this.$container.hasClass('expanded')) {
      return;
    }
    if (this.options.onBeforeExpand) {
      this.options.onBeforeExpand.call(this);
    }
    this.$overlay.remove();
    this.$container.addClass('expanded');
    if (this.$target) {
      setTimeout((function(_this) {
        return function() {
          return _this.$target.focus();
        };
      })(this), 1);
    }
    if (this.$target && this.options.placeholder) {
      this.$target.attr('placeholder', $('<div>' + this.options.placeholder + '</div>').text());
    }
    if (this.options.onAfterExpand) {
      return this.options.onAfterExpand.call(this);
    }
  };

  ExpandingInput.DEFAULTS = {
    target: null,
    hidden_content: null,
    placeholder: null,
    onBeforeExpand: null,
    onAfterExpand: null
  };

  $.fn.expandingInput = function(options) {
    return this.each(function() {
      var $this;
      $this = $(this);
      if (!$this.attr('data-expandingInput')) {
        return $.data($this, 'expandingInput', new ExpandingInput($this, options));
      }
    });
  };

  $.fn.expandingInput.Constructor = ExpandingInput;

}).call(this);
