# -------------------------------------------------------------------
# components / main-navbar.coffee
#

###
 * Class that provides the top navbar functionality.
 *
 * @class MainNavbar
###

PixelAdmin.MainNavbar = ->
  @_scroller = false
  @_wheight = null
  @scroll_pos = 0
  @

###
 * Initialize plugin.
###
PixelAdmin.MainNavbar.prototype.init = ->
  @$navbar                = $('#main-navbar')
  @$header                = @$navbar.find('.navbar-header')
  @$toggle                = @$navbar.find('.navbar-toggle:first')
  @$collapse              = $('#main-navbar-collapse')
  @$collapse_div          = @$collapse.find('> div')
  is_mobile               = false

  $(window).on 'pa.screen.small pa.screen.tablet', =>
    @_setupScroller() if @$navbar.css('position') is 'fixed'
    is_mobile = true
  .on 'pa.screen.desktop', =>
    @_removeScroller()
    is_mobile = false

  @$navbar.on 'click', '.nav-icon-btn.dropdown > .dropdown-toggle', (e) ->
    if is_mobile
      e.preventDefault()
      e.stopPropagation()
      document.location.href = $(@).attr('href')
      false

###
 * Attach scroller to navbar collapse.
###
PixelAdmin.MainNavbar.prototype._setupScroller = ->
  return if @_scroller
  @_scroller = true
  @$collapse_div.pixelSlimScroll({})

  # Add callbacks
  @$navbar.on('shown.bs.collapse.mn_collapse',  $.proxy((=> @_updateCollapseHeight(); @_watchWindowHeight();), @))
          .on('hidden.bs.collapse.mn_collapse', $.proxy((=> @_wheight = null; @$collapse_div.pixelSlimScroll({ scrollTo: '0px' }) ), @))
          .on('shown.bs.dropdown.mn_collapse',  $.proxy(@_updateCollapseHeight, @))
          .on('hidden.bs.dropdown.mn_collapse',  $.proxy(@_updateCollapseHeight, @))
  @_updateCollapseHeight()

###
 * Detach scroller from navbar collapse.
###
PixelAdmin.MainNavbar.prototype._removeScroller = ->
  return unless @_scroller
  
  @_wheight = null
  @_scroller = false
  @$collapse_div.pixelSlimScroll({ destroy: 'destroy' })

  # Remove callbacks
  @$navbar.off('shown.bs.collapse.mn_collapse')
  @$navbar.off('hidden.bs.collapse.mn_collapse')
  @$navbar.off('shown.bs.dropdown.mn_collapse')
  @$navbar.off('hidden.bs.dropdown.mn_collapse')
  @$collapse.attr('style', '')

###
 * Update navbar collapse height.
###
PixelAdmin.MainNavbar.prototype._updateCollapseHeight = ->
  return unless @_scroller

  w_height = $(window).innerHeight()
  h_height = @$header.outerHeight()
  scrollTop = @$collapse_div.scrollTop()

  # If current navbar height is greater than height of the window 
  if (h_height + @$collapse_div.css({'max-height': 'none'}).outerHeight()) > w_height
    @$collapse_div.css({'max-height': w_height - h_height})
  else
    @$collapse_div.css({'max-height': 'none'})
  @$collapse_div.pixelSlimScroll({scrollTo: scrollTop + 'px'})

###
 * Detecting a change of the window height.
###
PixelAdmin.MainNavbar.prototype._watchWindowHeight = ->
  @_wheight = $(window).innerHeight()
  checkWindowInnerHeight = =>
    return if @_wheight is null
    @_updateCollapseHeight() if @_wheight != $(window).innerHeight()
    @_wheight = $(window).innerHeight()
    setTimeout(checkWindowInnerHeight, 100)
  window.setTimeout(checkWindowInnerHeight, 100)


PixelAdmin.MainNavbar.Constructor = PixelAdmin.MainNavbar
PixelAdmin.addInitializer ->
  # Initialize plugin.
  PixelAdmin.initPlugin 'main_navbar', new PixelAdmin.MainNavbar