(function() {
  var PixelPlot;

  if (!$.fn.plot) {
    throw new Error('jquery.flot.js required');
  }


  /*
   * @class PixelPlot
   */

  PixelPlot = function($graph, graph_data, plot_options, options) {
    var available_colors, d, data, dataItem, previousPoint, timer, _i, _j, _len, _len1;
    if (options == null) {
      options = {};
    }
    this.options = $.extend(true, {}, PixelPlot.DEFAULTS, options || {});
    this.plot_options = $.extend(true, {}, PixelPlot.PLOT_DEFAULTS, plot_options || {});
    data = [];
    this.current_width = null;
    this.plot_obj = null;
    timer = null;
    available_colors = window.PixelAdmin.settings.consts.COLORS.slice(0);
    for (_i = 0, _len = graph_data.length; _i < _len; _i++) {
      d = graph_data[_i];
      data.push($.extend({}, d));
    }
    this.$graph = $graph.addClass('pa-flot-graph');
    this.$graph_container = $('<div class="pa-flot-container"></div>');
    this.$graph_info = $('<div class="pa-flot-info"></div>');
    this.$graph_container.insertAfter(this.$graph).append(this.$graph_info).append(this.$graph);
    this.resizeContainer();
    if (!data.length) {
      return;
    }
    for (_j = 0, _len1 = data.length; _j < _len1; _j++) {
      dataItem = data[_j];
      if (dataItem.color === void 0) {
        dataItem.color = available_colors.shift();
      }
      if (dataItem.filledPoints === true) {
        $.extend(true, dataItem, {
          points: {
            radius: this.options.pointRadius,
            fillColor: dataItem.color
          }
        });
        delete dataItem['filledPoints'];
      }
      this.$graph_info.append($('<span><i style="background: ' + dataItem.color + '"></i>' + dataItem.label + '</span>'));
    }
    this.plot_obj = $.plot($graph, data, this.plot_options);
    if (this.plot_options.series.pie === void 0) {
      previousPoint = null;
      $graph.bind('plothover', (function(_this) {
        return function(event, pos, item) {
          var x, y;
          if (item) {
            if (previousPoint !== item.dataIndex) {
              previousPoint = item.dataIndex;
              $('.pa-flot-tooltip').remove();
              x = item.datapoint[0];
              y = item.datapoint[1];
              return _this.showTooltip(item.pageX, item.pageY, eval(_this.options.tooltipText));
            }
          } else {
            $('.pa-flot-tooltip').remove();
            return previousPoint = null;
          }
        };
      })(this));
    }
    return $(window).on('pa.resize', $.proxy(this.resizeContainer, this));
  };

  PixelPlot.prototype.resizeContainer = function() {
    var height, width;
    width = this.$graph_container.innerWidth();
    if (width === this.current_width) {
      return;
    }
    height = this.options.height === null ? Math.ceil(width * this.options.heightRatio) : this.options.height;
    this.$graph.css({
      width: width,
      height: height
    });
    this.current_width = width;
    if (this.plot_obj) {
      this.plot_obj.getPlaceholder().css({
        width: width,
        height: height
      });
      this.plot_obj.resize();
      this.plot_obj.setupGrid();
      return this.plot_obj.draw();
    }
  };

  PixelPlot.prototype.showTooltip = function(x, y, contents) {
    var tooltip;
    tooltip = $('<div class="pa-flot-tooltip">' + contents + '</div>').appendTo('body');
    if ((x + 20 + tooltip.width()) > (this.$graph_container.offset().left + this.$graph_container.width())) {
      x -= 40 + tooltip.width();
    } else {
      x += 20;
    }
    return tooltip.css({
      top: y - 16,
      left: x
    }).fadeIn();
  };

  PixelPlot.DEFAULTS = {
    pointRadius: 4,
    height: null,
    heightRatio: 0.5,
    tooltipText: 'x - y'
  };

  PixelPlot.PLOT_DEFAULTS = {
    series: {
      shadowSize: 0
    },
    grid: {
      color: '#999',
      borderColor: '#fff',
      borderWidth: 1,
      hoverable: true
    },
    xaxis: {
      tickColor: '#fff'
    },
    legend: {
      show: false
    }
  };

  $.fn.pixelPlot = function(graph_data, plot_options, options) {
    return this.each(function() {
      var pflot;
      pflot = $.data(this, 'PixelPlot');
      if (!pflot) {
        return $.data(this, 'PixelPlot', new PixelPlot($(this), graph_data, plot_options, options));
      } else {
        if (plot_options === 'resizeContainer') {
          return pflot.resizeContainer();
        }
      }
    });
  };

  $.fn.pixelPlot.Constructor = PixelPlot;

}).call(this);
