(function() {
  var Rating;

  Rating = function($el, options) {
    var i, self, _i, _ref;
    if (options == null) {
      options = {};
    }
    this.options = $.extend({}, Rating.DEFAULTS, options);
    this.$container = $('<ul class="widget-rating"></ul>');
    for (i = _i = 0, _ref = this.options.stars_count; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      this.$container.append($('<li><a href="#" title="" class="widget-rating-item"></a></li>'));
    }
    $el.append(this.$container);
    self = this;
    this.$container.find('a').on('mouseenter', function() {
      self.$container.find('li').removeClass(self.options.class_active);
      return $(this).parents('li').addClass(self.options.class_active).prevAll('li').addClass(self.options.class_active);
    }).on('mouseleave', function() {
      return self.setRating(self.options.rating);
    }).on('click', function() {
      self.options.onRatingChange.call(self, $(this).parents('li').prevAll('li').length + 1);
      return false;
    });
    this.setRating(this.options.rating);
    return this;
  };

  Rating.prototype.setRating = function(value) {
    this.options.rating = value;
    if ((value - Math.floor(value)) > this.options.lower_limit) {
      value = Math.ceil(value);
    } else {
      value = Math.floor(value);
    }
    return this.$container.find('li').removeClass(this.options.class_active).slice(0, value).addClass(this.options.class_active);
  };

  Rating.DEFAULTS = {
    stars_count: 5,
    rating: 0,
    class_active: 'active',
    lower_limit: 0.35,
    onRatingChange: function(value) {}
  };

  $.fn.pixelRating = function(options, args) {
    return $(this).each(function() {
      var $this, pr;
      $this = $(this);
      pr = $.data(this, 'pixelRating');
      if (!pr) {
        return $.data(this, 'pixelRating', new Rating($this, options));
      } else if (options === 'setRating') {
        return pr.setRating(args);
      }
    });
  };

  $.fn.pixelRating.Constructor = Rating;

}).call(this);
