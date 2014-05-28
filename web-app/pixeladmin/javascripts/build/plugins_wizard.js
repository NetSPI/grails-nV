(function() {
  var Wizard, setElementWidth;

  setElementWidth = function($el, width) {
    return $el.css({
      'width': width,
      'max-width': width,
      'min-width': width
    });
  };


  /*
   * @class Wizard
   */

  Wizard = function($element, options) {
    var $cur_step, self;
    if (options == null) {
      options = {};
    }
    this.options = $.extend({}, Wizard.DEFAULTS, options || {});
    this.$element = $element;
    this.$wrapper = $('.wizard-wrapper', this.$element);
    this.$steps = $('.wizard-steps', this.$wrapper);
    this.$step_items = $('> li', this.$steps);
    this.steps_count = this.$step_items.length;
    this.$content = $('.wizard-content', this.$element);
    this.current_step = null;
    this.$current_item = null;
    this.isFreeze = false;
    this.isRtl = $('body').hasClass('right-to-left');
    this.resizeStepItems();
    $cur_step = $('> li.active', this.$steps);
    if ($cur_step.length === 0) {
      $cur_step = $('> li:first-child', this.$steps);
    }
    this.$current_item = $cur_step.addClass('active');
    this.current_step = $cur_step.index() + 1;
    $($cur_step.attr('data-target'), this.$content).css({
      display: 'block'
    });
    this.placeStepItems();
    this._setPrevItemStates(this.current_step - 1);
    $(window).on('pa.resize.wizard', (function(_this) {
      return function() {
        $.proxy(_this.resizeStepItems, _this)();
        return $.proxy(_this.placeStepItems, _this)();
      };
    })(this));
    self = this;
    this.$steps.on('click', '> li', function() {
      var $this;
      $this = $(this);
      if ($this.hasClass('completed')) {
        return self.setCurrentStep($this.index() + 1);
      }
    });
    return this;
  };

  Wizard.DEFAULTS = {
    step_item_min_width: 200,
    onChange: null,
    onFinish: null
  };


  /*
   * Resize steps
   */

  Wizard.prototype.resizeStepItems = function() {
    var width;
    if (this.$element.width() > (Wizard.DEFAULTS.step_item_min_width * this.$step_items.length)) {
      width = Math.floor(this.$element.width() / this.$step_items.length);
    } else {
      width = Wizard.DEFAULTS.step_item_min_width;
    }
    return this.$step_items.each(function() {
      return setElementWidth($(this), width);
    });
  };


  /*
   * Move steps
   */

  Wizard.prototype.placeStepItems = function() {
    var current_item_width, d, element_width, item_position, item_position_right, offset, steps_width;
    offset = 0;
    item_position = this.$current_item.position();
    element_width = this.$element.outerWidth();
    steps_width = this.$steps.outerWidth();
    current_item_width = this.$current_item.outerWidth();
    d = (element_width - current_item_width) / 2;
    if (!this.isRtl) {
      if (element_width < steps_width && item_position.left > d) {
        offset = -1 * item_position.left + d;
        if ((steps_width + offset) < element_width) {
          offset = -1 * steps_width + element_width;
        }
      }
      return this.$steps.css({
        left: offset
      });
    } else {
      item_position_right = steps_width - item_position.left - current_item_width;
      if (element_width < steps_width && item_position_right > d) {
        offset = -1 * item_position_right + d;
        if ((steps_width + offset) < element_width) {
          offset = -1 * steps_width + element_width;
        }
      }
      return this.$steps.css({
        right: offset
      });
    }
  };


  /*
   * Change step
   *
   * @param {Integer} step
   */

  Wizard.prototype.setCurrentStep = function(step) {
    if (this.isFreeze) {
      return;
    }
    return $(this.$current_item.attr('data-target'), this.$content).css({
      opacity: 1
    }).animate({
      opacity: 0
    }, 200, (function(_this) {
      return function() {
        $(_this.$current_item.attr('data-target'), _this.$content).attr('style', '');
        _this._clearItemStates(step - 1);
        _this.$current_item = _this.$step_items.eq(step - 1).addClass('active');
        _this.current_step = step;
        _this._setPrevItemStates(step - 1);
        return $(_this.$current_item.attr('data-target'), _this.$content).css({
          display: 'block',
          opacity: 0
        }).animate({
          opacity: 1
        }, 200, function() {
          if (_this.options.onChange) {
            $.proxy(_this.options.onChange, _this)();
          }
          return _this.placeStepItems();
        });
      };
    })(this));
  };


  /*
   * Move to next step
   */

  Wizard.prototype.nextStep = function() {
    if (this.isFreeze) {
      return;
    }
    if (this.current_step >= this.steps_count) {
      if (this.options.onFinish) {
        $.proxy(this.options.onFinish, this)();
      }
      return;
    }
    this.$current_item.removeClass('active').addClass('completed');
    return this.setCurrentStep(this.current_step + 1);
  };


  /*
   * Move to previous step
   */

  Wizard.prototype.prevStep = function() {
    if (this.isFreeze) {
      return;
    }
    if (this.current_step <= 1) {
      return;
    }
    return this.setCurrentStep(this.current_step - 1);
  };


  /*
   * Get current step
   */

  Wizard.prototype.currentStep = function() {
    return this.current_step;
  };


  /*
   * @param {Integer} start_index
   */

  Wizard.prototype._clearItemStates = function(start_index) {
    var i, _i, _ref, _results;
    _results = [];
    for (i = _i = start_index, _ref = this.steps_count; start_index <= _ref ? _i < _ref : _i > _ref; i = start_index <= _ref ? ++_i : --_i) {
      _results.push(this.$step_items.eq(i).removeClass('active').removeClass('completed'));
    }
    return _results;
  };


  /*
   * @param {Integer} end_index
   */

  Wizard.prototype._setPrevItemStates = function(end_index) {
    var i, _i, _results;
    _results = [];
    for (i = _i = 0; 0 <= end_index ? _i < end_index : _i > end_index; i = 0 <= end_index ? ++_i : --_i) {
      _results.push(this.$step_items.eq(i).addClass('completed'));
    }
    return _results;
  };


  /*
   * Freeze wizard
   */

  Wizard.prototype.freeze = function() {
    this.isFreeze = true;
    return this.$element.addClass('freeze');
  };


  /*
   * Unfreeze wizard
   */

  Wizard.prototype.unfreeze = function() {
    this.isFreeze = false;
    return this.$element.removeClass('freeze');
  };


  /*
   * jQuery Wizard plugin initialization
   *
   * @param {Object|String} options
   * @param {Object} attrs
   */

  $.fn.pixelWizard = function(options, attrs) {
    var $set, methodReturn;
    methodReturn = void 0;
    $set = this.each(function() {
      var $this, wizard_obj;
      $this = $(this);
      if (!$.data(this, 'pixelWizard')) {
        return $.data(this, 'pixelWizard', new Wizard($this, options));
      } else if (options && typeof options === 'string') {
        wizard_obj = $.data(this, 'pixelWizard');
        if (options === 'setCurrentStep') {
          return wizard_obj.setCurrentStep(attrs);
        } else if (options === 'currentStep') {
          return methodReturn = wizard_obj.currentStep();
        } else if (options === 'nextStep') {
          return wizard_obj.nextStep();
        } else if (options === 'prevStep') {
          return wizard_obj.prevStep();
        } else if (options === 'freeze') {
          return wizard_obj.freeze();
        } else if (options === 'unfreeze') {
          return wizard_obj.unfreeze();
        } else if (options === 'resizeSteps') {
          return wizard_obj.resizeStepItems();
        }
      }
    });
    return (methodReturn === void 0 ? $set : methodReturn);
  };

  $.fn.pixelWizard.Constructor = Wizard;

}).call(this);
