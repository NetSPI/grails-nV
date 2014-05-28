
/*
 * @class FileInput
 */

(function() {
  var FileInput;

  FileInput = function($input, options) {
    if (options == null) {
      options = {};
    }
    this.options = $.extend({}, FileInput.DEFAULTS, options || {});
    this.$input = $input;
    this.$el = $('<div class="pixel-file-input"><span class="pfi-filename"></span><div class="pfi-actions"></div></div>').insertAfter($input).append($input);
    this.$filename = $('.pfi-filename', this.$el);
    this.$clear_btn = $(this.options.clear_btn_tmpl).addClass('pfi-clear').appendTo($('.pfi-actions', this.$el));
    this.$choose_btn = $(this.options.choose_btn_tmpl).addClass('pfi-choose').appendTo($('.pfi-actions', this.$el));
    this.onChange();
    $input.on('change', (function(_this) {
      return function() {
        return $.proxy(_this.onChange, _this)();
      };
    })(this)).on('click', function(e) {
      return e.stopPropagation();
    });
    this.$el.on('click', function() {
      return $input.click();
    });
    this.$choose_btn.on('click', function(e) {
      return e.preventDefault();
    });
    return this.$clear_btn.on('click', (function(_this) {
      return function(e) {
        $input.wrap('<form>').parent('form').trigger('reset');
        $input.unwrap();
        $.proxy(_this.onChange, _this)();
        e.stopPropagation();
        return e.preventDefault();
      };
    })(this));
  };

  FileInput.DEFAULTS = {
    choose_btn_tmpl: '<a href="#" class="btn btn-xs btn-primary">Choose</a>',
    clear_btn_tmpl: '<a href="#" class="btn btn-xs"><i class="fa fa-times"></i> Clear</a>',
    placeholder: null
  };

  FileInput.prototype.onChange = function() {
    var value;
    value = this.$input.val().replace(/\\/g, '/');
    if (value !== '') {
      this.$clear_btn.css('display', 'inline-block');
      this.$filename.removeClass('pfi-placeholder');
      return this.$filename.text(value.split('/').pop());
    } else {
      this.$clear_btn.css('display', 'none');
      if (this.options.placeholder) {
        this.$filename.addClass('pfi-placeholder');
        return this.$filename.text(this.options.placeholder);
      } else {
        return this.$filename.text('');
      }
    }
  };

  $.fn.pixelFileInput = function(options) {
    return this.each(function() {
      if (!$.data(this, 'pixelFileInput')) {
        return $.data(this, 'pixelFileInput', new FileInput($(this), options));
      }
    });
  };

  $.fn.pixelFileInput.Constructor = FileInput;

}).call(this);
