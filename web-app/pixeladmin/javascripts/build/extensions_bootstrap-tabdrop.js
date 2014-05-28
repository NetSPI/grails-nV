(function() {
  var tabdrop;

  if (!$.fn.tabdrop) {
    throw new Error('bootstrap-tabdrop.js required');
  }

  tabdrop = $.fn.tabdrop;

  $.fn.tabdrop = function(options) {
    options = $.extend({}, $.fn.tabdrop.defaults, options);
    return this.each(function() {
      var $this, data;
      $this = $(this);
      tabdrop.call($this, options);
      data = $this.data('tabdrop');
      if (data) {
        data.dropdown.on("click", "li", function() {
          $(this).parent().parent().find("a.dropdown-toggle").empty().html('<span class="display-tab"> ' + $(this).text() + ' </span><b class="caret"></b>');
          return data.layout();
        });
        return data.element.on('click', '> li', function() {
          if ($(this).hasClass('tabdrop')) {
            return;
          }
          data.element.find("> .tabdrop > a.dropdown-toggle").empty().html(options.text + ' <b class="caret"></b>');
          return data.layout();
        });
      }
    });
  };

  $.fn.tabdrop.defaults = {
    text: '<i class="fa fa-bars"></i>'
  };

}).call(this);
