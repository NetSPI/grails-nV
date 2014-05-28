# -------------------------------------------------------------------
# plugins / flot.coffee

throw new Error('jquery.flot.js required') if not $.fn.plot


###
 * @class PixelPlot
###

PixelPlot = ($graph, graph_data, plot_options, options={}) ->
  @options      = $.extend(true, {}, PixelPlot.DEFAULTS, options || {})
  @plot_options = $.extend(true, {}, PixelPlot.PLOT_DEFAULTS, plot_options || {})

  data = []
  @current_width = null

  @plot_obj = null
  timer = null
  available_colors = window.PixelAdmin.settings.consts.COLORS.slice(0)

  # Clone initial data
  data.push($.extend({}, d)) for d in graph_data
  
  @$graph = $graph.addClass('pa-flot-graph')
  @$graph_container = $('<div class="pa-flot-container"></div>')
  @$graph_info = $('<div class="pa-flot-info"></div>')

  @$graph_container.insertAfter(@$graph).append(@$graph_info).append(@$graph)
  @resizeContainer()

  # Prepare data hash and setup labels
  return unless data.length
  for dataItem in data
    dataItem.color = available_colors.shift() if dataItem.color is undefined

    if dataItem.filledPoints is true
      $.extend true, dataItem,
        points:
          radius: @options.pointRadius,
          fillColor: dataItem.color
      delete dataItem['filledPoints']

    @$graph_info.append($('<span><i style="background: ' + dataItem.color + '"></i>' + dataItem.label + '</span>'))

  # Initialize Flot plugin
  @plot_obj = $.plot($graph, data, @plot_options)

  # Setup tooltips
  if @plot_options.series.pie is undefined
    previousPoint = null
    $graph.bind 'plothover', (event, pos, item) =>
      if item
        if previousPoint isnt item.dataIndex
          previousPoint = item.dataIndex
          $('.pa-flot-tooltip').remove()
          x = item.datapoint[0]
          y = item.datapoint[1]
          @showTooltip(item.pageX, item.pageY, eval(@options.tooltipText))
      else
        $('.pa-flot-tooltip').remove()
        previousPoint = null

  # Setup resize event callback
  $(window).on 'pa.resize', $.proxy(@resizeContainer, @)


PixelPlot.prototype.resizeContainer = ->
  width = @$graph_container.innerWidth()
  return if width is @current_width
  height = if @options.height is null then Math.ceil(width * @options.heightRatio) else @options.height

  @$graph.css
    width: width
    height: height
  @current_width = width

  if @plot_obj
    @plot_obj.getPlaceholder().css
      width: width,
      height: height

    @plot_obj.resize()
    @plot_obj.setupGrid()
    @plot_obj.draw()

PixelPlot.prototype.showTooltip = (x, y, contents) ->
  tooltip = $('<div class="pa-flot-tooltip">' + contents + '</div>').appendTo('body')
  if (x + 20 + tooltip.width()) > (@$graph_container.offset().left + @$graph_container.width())
    x -= 40 + tooltip.width() 
  else
    x += 20
  tooltip.css
    top: y - 16
    left: x
  .fadeIn()


PixelPlot.DEFAULTS = 
  # Radius of graph points
  pointRadius: 4,

  # Height of container. By default it is calculated dynamically
  # when the container width changing. When the height option is
  # passed then the container height does not depend on the
  # container width.
  height: null,

  # heightRatio is used when the container height is calculated dynamically.
  # containerHeight = containerWidth * heightRatio
  heightRatio: 0.5,

  # Warning: Tooltip text is passed to a JavaScript's eval function.
  tooltipText: 'x - y'


PixelPlot.PLOT_DEFAULTS = 
  series:
    shadowSize: 0
  grid:
    color: '#999',
    borderColor: '#fff',
    borderWidth: 1,
    hoverable: true
  xaxis:
    tickColor: '#fff'
  legend: 
    show: false


$.fn.pixelPlot = (graph_data, plot_options, options) ->
  @each ->
    pflot = $.data(@, 'PixelPlot')
    if not pflot
      $.data @, 'PixelPlot', new PixelPlot($(@), graph_data, plot_options, options)
    else
      if plot_options is 'resizeContainer'
        pflot.resizeContainer()

$.fn.pixelPlot.Constructor = PixelPlot