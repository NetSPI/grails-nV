(function() {
  var Tasks;

  Tasks = function($el, options) {
    var self;
    if (options == null) {
      options = {};
    }
    this.$el = $el;
    this.options = $.extend({}, Tasks.DEFAULTS, options);
    self = this;
    $el.on('click', '.task input[type=checkbox]', function() {
      return self.completeTask($(this));
    }).on('click', '.task a', function() {
      $(this).parents('.task').find('input[type=checkbox]').click();
      return false;
    });
    return this;
  };

  Tasks.prototype.completeTask = function($trigger) {
    var $task;
    $task = $trigger.parents('.task');
    if ($task.toggleClass('completed').hasClass('completed')) {
      return this.options.onComplete.call(this);
    } else {
      return this.options.onCancel.call(this);
    }
  };

  Tasks.prototype.clearCompletedTasks = function() {
    $('.completed', this.$el).hide(200, function() {
      return $(this).remove();
    });
    return this.options.onClear.call(this);
  };

  Tasks.DEFAULTS = {
    onComplete: function() {},
    onCancel: function() {},
    onClear: function() {}
  };

  $.fn.pixelTasks = function(options) {
    return $(this).each(function() {
      var $this, pt;
      $this = $(this);
      pt = $.data(this, 'pixelTasks');
      if (!pt) {
        return $.data(this, 'pixelTasks', new Tasks($this, options));
      } else if (options === 'clearCompletedTasks') {
        return pt.clearCompletedTasks();
      }
    });
  };

  $.fn.pixelTasks.Constructor = Tasks;

}).call(this);
