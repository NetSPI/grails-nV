# -------------------------------------------------------------------
# extensions / jquery.sparklines.coffee
#

throw new Error('jquery.sparkline.js required') if not $.fn.sparkline

getBarWidth = ($el, count, space) ->
  w = $el.outerWidth()
  s = parseInt(space) * (count - 1)
  Math.floor((w - s) / count)

$.fn.pixelSparkline = () ->
  f_args = arguments
  is_bars = false
  vals_count = 0
  bars_space = '2px'
  if f_args[0] instanceof Array and f_args[1] instanceof Object and f_args[1].type is 'bar' and f_args[1].width is '100%'
    is_bars = true
    vals_count = f_args[0].length
    bars_space = f_args[1].barSpacing if f_args[1].barSpacing
    f_args[1].barWidth = getBarWidth($(@), vals_count, bars_space)
  $.fn.sparkline.apply(@, f_args)
  $(window).on 'pa.resize', =>
    if is_bars
      f_args[1].barWidth = getBarWidth($(@), vals_count, bars_space)
    $.fn.sparkline.apply(@, f_args)
