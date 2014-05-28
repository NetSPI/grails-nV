# -------------------------------------------------------------------
# plugins / switcher.coffee
#

###
 * @class Switcher
###

Switcher = ($el, options={}) ->
  @options = $.extend({}, Switcher.DEFAULTS, options)
  @$checkbox = null
  @$box = null

  # If called on a checkbox
  if $el.is('input[type="checkbox"]')
    box_class = $el.attr('data-class')
    @$checkbox = $el
    # Create container
    @$box = $('<div class="switcher"><div class="switcher-toggler"></div><div class="switcher-inner"><div class="switcher-state-on">' + @options.on_state_content + '</div><div class="switcher-state-off">' + @options.off_state_content + '</div></div></div>')
    @$box.addClass('switcher-theme-' + @options.theme) if @options.theme
    @$box.addClass(box_class) if box_class
    @$box.insertAfter(@$checkbox).prepend(@$checkbox)
  else
    @$box = $el
    @$checkbox = $('input[type="checkbox"]', @$box)

  # Disable switcher if checkbox is disabled
  @$box.addClass('disabled') if @$checkbox.prop('disabled')
  # Set switcher on if checkbox is checked
  @$box.addClass('checked') if @$checkbox.is(':checked')

  @$checkbox.on 'click', (e) ->
    e.stopPropagation()

  @$box.on 'touchend click', (e) =>
    e.stopPropagation()
    e.preventDefault()
    @toggle()
  @

###
 * Enable switcher.
 *
###
Switcher.prototype.enable = ->
  # enable checkbox
  @$checkbox.prop('disabled', false)
  @$box.removeClass('disabled')

###
 * Disable switcher.
 *
###
Switcher.prototype.disable = ->
  # disable checkbox
  @$checkbox.prop('disabled', true)
  @$box.addClass('disabled')

###
 * Set switcher to true.
 *
###
Switcher.prototype.on = ->
  if not @$checkbox.is(':checked')
    @$checkbox.click()
    @$box.addClass('checked')

###
 * Set switcher to false.
 *
###
Switcher.prototype.off = ->
  if @$checkbox.is(':checked')
    @$checkbox.click()
    @$box.removeClass('checked')

###
 * Toggle switcher.
 *
###
Switcher.prototype.toggle = ->
  if @$checkbox.click().is(':checked')
    @$box.addClass('checked')
  else
    @$box.removeClass('checked')

# Default options
Switcher.DEFAULTS =
  theme: null               # Theme
  on_state_content:  'ON'   # On-text (html allowed)
  off_state_content: 'OFF'  # Off-text (html allowed)

# Initializer
$.fn.switcher = (options, attrs) ->
  $(@).each ->
    $this = $(@)

    sw = $.data(@, 'Switcher')
    if not sw
      $.data(@, 'Switcher', new Switcher($this, options))
    else if options is 'enable'
      sw.enable()
    else if options is 'disable'
      sw.disable()
    else if options is 'on'
      sw.on()
    else if options is 'off'
      sw.off()
    else if options is 'toggle'
      sw.toggle()

$.fn.switcher.Constructor = Switcher
