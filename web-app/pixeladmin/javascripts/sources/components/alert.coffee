# -------------------------------------------------------------------
# components / alerts.coffee
#

ALERTS_CONTAINER_ID = 'pa-page-alerts-box'


###
 * @class Alert
###

Alert = ->
  @

Alert.DEFAULTS = 
  type:       'warning' # Default types: warning, danger, success, info
  close_btn:  true
  classes:    false # string or false
  namespace:  'pa_page_alerts'
  animate:    true
  auto_close: false # seconds or false

Alert.TYPES_HASH =
  warning: ''
  danger:  'alert-danger'
  success: 'alert-success'
  info:    'alert-info'

###
 * Initialize plugin.
###
Alert.prototype.init = ->
  self = @
  # Close button
  $('#main-wrapper').on 'click.pa.alerts', '#' + ALERTS_CONTAINER_ID + ' .close', ->
    self.close $(@).parents('.alert')
    false

###
 * Add new alert.
 *
 * @param  {String} html
 * @param  {Object} options
###
Alert.prototype.add = (html, options) ->
  # Extend default options
  options = $.extend({}, Alert.DEFAULTS, options || {});
  # Create alert
  $alert = $('<div class="alert alert-page ' + options.namespace + ' ' + Alert.TYPES_HASH[options.type] + '" />').html(html)
  # Add custom classes
  $alert.addClass(options.classes) if options.classes
  # Add close button
  $alert.prepend($('<button type="button" class="close" />').html('&times;')) if options.close_btn
  # Add 'data-animate' attribute
  $alert.attr('data-animate', 'true') if options.animate

  $box = $('#' + ALERTS_CONTAINER_ID)
  # Create container if its not exist 
  $box = $('<div id="' + ALERTS_CONTAINER_ID + '" />').prependTo($('#content-wrapper')) unless $box.length

  # Get alerts with the given namespace
  $alerts = $('#' + ALERTS_CONTAINER_ID + ' .' + options.namespace)

  # Get parameters
  height = $alert.css({ visibility: 'hidden', position: 'absolute', width: '100%' }).appendTo('body').outerHeight()
  padding_top = $alert.css('padding-top')
  padding_bottom = $alert.css('padding-bottom')

  # Prepare to animation
  $alert.attr('style', '').css({ overflow: 'hidden', height: 0, 'padding-top': 0, 'padding-bottom': 0 }) if options.animate

  # Add alert to the end of the namespace if there is alerts with the given namespace
  if $alerts.length
    $alerts.last().after($alert)
  # Or just append alert to the container 
  else
    $box.append($alert)
  
  if options.animate
    $alert.animate { 'height': height, 'padding-top': padding_top, 'padding-bottom': padding_bottom }, 500, =>
      $alert.attr 'style', ''
      # Add close timeout
      if options.auto_close
        $.data $alert, 'timer', setTimeout(=>
          @close $alert
        , options.auto_close * 1000)
  else
    $alert.attr 'style', ''

###
 * Close alert.
 *
 * @param  {jQuery Object} $alert
###
Alert.prototype.close = ($alert) ->
  if $alert.attr('data-animate') is 'true'
    $alert.animate { 'height': 0, 'padding-top': 0, 'padding-bottom': 0 }, 500, ->
      # clear auto_close timeout
      clearTimeout($.data($alert, 'timer')) if $.data($alert, 'timer')
      $alert.remove()
  else
    # clear auto_close timeout
    clearTimeout($.data($alert, 'timer')) if $.data($alert, 'timer')
    $alert.remove()

###
 * Close all alerts with specified namespace.
 *
 * @param  {Boolean} animate
 * @param  {String} namespace
###
Alert.prototype.clear = (animate=true, namespace='pa_page_alerts') ->
  $alerts = $('#' + ALERTS_CONTAINER_ID + ' .' + namespace)
  if $alerts.length
    self = @
    if animate
      # Close all alerts in the loop
      $alerts.each ->
        self.close $(this)
    else
      $alerts.remove()

###
 * Close all alerts.
 *
 * @param  {Boolean} animate
###
Alert.prototype.clearAll = (animate=true) ->
  if animate
    self = @
    # Close all alerts in the loop
    $('#' + ALERTS_CONTAINER_ID + ' .alert').each ->
      self.close $(this)
  else
    # Just remove container
    $('#' + ALERTS_CONTAINER_ID).remove()

###
 * Returns alerts container ID.
###
Alert.prototype.getContainerId = ->
  ALERTS_CONTAINER_ID


Alert.Constructor = Alert
PixelAdmin.addInitializer ->
  # Initialize plugin.
  PixelAdmin.initPlugin 'alerts', new Alert