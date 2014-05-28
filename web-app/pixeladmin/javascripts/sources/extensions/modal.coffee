# -------------------------------------------------------------------
# extensions / modal.coffee
#

return if not $.fn.modal or not $.fn.Vague or not $('html').hasClass('not-ie')

modal_show = $.fn.modal.Constructor.prototype.show
modal_hide = $.fn.modal.Constructor.prototype.hide

$Vague = null
_blurred = false  # is background blurred?

# Turn on blur effect
blurOn = ->
  return if _blurred
  $Vague = $('#main-wrapper').Vague({
    intensity:   3     # Blur Intensity
    forceSVGUrl: false # Force absolute path to the SVG filter
  }) unless $Vague
  $Vague.blur()
  _blurred = true

# Turn off blur effect
blurOff = ->
  return unless _blurred
  $Vague.unblur() if $Vague
  _blurred = false


# Extend modals
#

# Show modal
$.fn.modal.Constructor.prototype.show = () ->
  modal_show.call(@)
  if @$element.hasClass('modal-blur')
    # Move modal to the end of the body
    $('body').append @$element

    # Enable blur effect only on desktops
    blurOn() if getScreenSize($('#small-screen-width-point'), $('#tablet-screen-width-point')) == 'desktop'

    $(window).on 'pa.resize.modal_blur', ->
      if getScreenSize($('#small-screen-width-point'), $('#tablet-screen-width-point')) == 'desktop'
        blurOn()
      else
        blurOff()
  else
    blurOff()

# Hide modal
$.fn.modal.Constructor.prototype.hide = () ->
  modal_hide.call(@)
  blurOff()
  $(window).off('pa.resize.modal_blur').on('hidden', '.modal', ->
    alert 'asd'
  )
