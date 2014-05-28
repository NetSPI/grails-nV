# -------------------------------------------------------------------
# events.coffee
#

delayedResizeHandler = (callback) ->
  resizeTimer = null
  ->
    clearTimeout(resizeTimer) if resizeTimer
    resizeTimer = setTimeout(->
      resizeTimer = null
      callback.call(@)
    , PixelAdmin.settings.resize_delay)

PixelAdmin.addInitializer () ->
  _last_screen = null
  $window = $(window)
  $ssw_point = $('<div id="small-screen-width-point" style="position:absolute;top:-10000px;width:10px;height:10px;background:#fff;"></div>')
  $tsw_point = $('<div id="tablet-screen-width-point" style="position:absolute;top:-10000px;width:10px;height:10px;background:#fff;"></div>')
  $('body').append($ssw_point).append($tsw_point)

  $window.on 'resize', delayedResizeHandler ->
    $window.trigger("pa.resize")
    if $ssw_point.is(':visible')
      $window.trigger("pa.screen.small") if _last_screen isnt 'small'
      _last_screen = 'small'
    else if $tsw_point.is(':visible')
      $window.trigger("pa.screen.tablet") if _last_screen isnt 'tablet'
      _last_screen = 'tablet'
    else
      $window.trigger("pa.screen.desktop") if _last_screen isnt 'desktop'
      _last_screen = 'desktop'

