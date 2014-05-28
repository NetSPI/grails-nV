# -------------------------------------------------------------------
# app.coffee
#

# Default app settings
SETTINGS_DEFAULTS =
  is_mobile: false
  resize_delay: 400 # resize event delay (milliseconds)
  stored_values_prefix: 'pa_' # prefix for strored values in the localStorage and cookies
  main_menu:
    accordion: true
    animation_speed: 250 # milliseconds
    store_state: true # Remember collapsed/expanded state on desktops
    store_state_key: 'mmstate'
    disable_animation_on: ['small'] # Disable animation on specified screen sizes for the perfomance reason. Possible values: 'small', 'tablet', 'desktop'
    dropdown_close_delay: 300 # milliseconds
    detect_active: true,
    detect_active_predicate: (href, url) -> return (href is url)
  consts:
    COLORS: ['#71c73e', '#77b7c5', '#d54848', '#6c42e5', '#e8e64e', '#dd56e6', '#ecad3f', '#618b9d', '#b68b68', '#36a766', '#3156be', '#00b3ff', '#646464', '#a946e8', '#9d9d9d']

###
 * @class PixelAdminApp
###

PixelAdminApp = ->
  @init     = [] # Initialization stack
  @plugins  = {} # Plugins list
  @settings = {} # Settings
  @localStorageSupported = if typeof(window.Storage) isnt "undefined" then true else false
  @

###
 * Start application. Method takes an array of initializers and a settings object(that overrides default settings).
 * 
 * @param  {Array} suffix
 * @param  {Object} settings
 * @return this
###
PixelAdminApp.prototype.start = (init=[], settings={}) ->
  window.onload = =>
    $('html').addClass('pxajs')
    if init.length > 0
      $.merge(@init, init)

    # Extend settings
    @settings = $.extend(true, {}, SETTINGS_DEFAULTS, settings || {})

    # Detect device
    @settings.is_mobile = /iphone|ipad|ipod|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase());

    # # If mobile than enable FastClick plugin
    # # (see https://github.com/ftlabs/fastclick)
    if @settings.is_mobile
      FastClick.attach(document.body) if FastClick

    # Run initializers
    $.proxy(initilizer, @)() for initilizer in @init

    $(window).trigger("pa.loaded")

    # Trigger resize event
    $(window).resize()
  @

###
 * Add initializer to the stack.
 * 
 * @param  {Function} callback
###
PixelAdminApp.prototype.addInitializer = (callback) ->
  @init.push(callback)

###
 * Initialize plugin and add it to the plugins list.
 * 
 * @param  {String} plugin_name
 * @param  {Instance} plugin
###
PixelAdminApp.prototype.initPlugin = (plugin_name, plugin) ->
  @plugins[plugin_name] = plugin
  plugin.init() if plugin.init

###
 * Save value in the localStorage/Cookies.
 * 
 * @param  {String}  key
 * @param  {String}  value
 * @param  {Boolean} use_cookies
###
PixelAdminApp.prototype.storeValue = (key, value, use_cookies=false) ->
  if @localStorageSupported and not use_cookies
    try
      window.localStorage.setItem(@settings.stored_values_prefix + key, value)
      return
    catch e
      1
  document.cookie = @settings.stored_values_prefix + key + '=' + escape(value)

###
 * Save key/value pairs in the localStorage/Cookies.
 * 
 * @param  {Object} pairs
 * @param  {Boolean} use_cookies
###
PixelAdminApp.prototype.storeValues = (pairs, use_cookies=false) ->
  if @localStorageSupported and not use_cookies
    try
      for key, value of pairs
        window.localStorage.setItem(@settings.stored_values_prefix + key, value)
      return
    catch e
      1
  for key, value of pairs
    document.cookie = @settings.stored_values_prefix + key + '=' + escape(value)

###
 * Get value from the localStorage/Cookies.
 * 
 * @param  {String} key
 * @param  {Boolean} use_cookies
###
PixelAdminApp.prototype.getStoredValue = (key, use_cookies=false, deflt=null) ->
  if @localStorageSupported and not use_cookies
    try
      r = window.localStorage.getItem(@settings.stored_values_prefix + key)
      return (if r then r else deflt)
    catch e
      1

  cookies = document.cookie.split(';')
  for cookie in cookies
    pos = cookie.indexOf('=')
    k = cookie.substr(0,  pos).replace(/^\s+|\s+$/g, '')
    v = cookie.substr(pos + 1).replace(/^\s+|\s+$/g, '')
    return v if k is (@settings.stored_values_prefix + key)
  return deflt

###
 * Get values from the localStorage/Cookies.
 * 
 * @param  {Array} keys
 * @param  {Boolean} use_cookies
###
PixelAdminApp.prototype.getStoredValues = (keys, use_cookies=false, deflt=null) ->
  result = {}
  result[key] = deflt for key in keys

  if @localStorageSupported and not use_cookies
    try
      for key in keys
        r = window.localStorage.getItem(@settings.stored_values_prefix + key)
        result[key] = r if r
      return result
    catch e
      1
  
  cookies = document.cookie.split(';')
  for cookie in cookies
    pos = cookie.indexOf('=')
    k = cookie.substr(0,  pos).replace(/^\s+|\s+$/g, '')
    v = cookie.substr(pos + 1).replace(/^\s+|\s+$/g, '')
    result[key] = v if k is (@settings.stored_values_prefix + key)
  result


# Create application
PixelAdminApp.Constructor = PixelAdminApp;
window.PixelAdmin = new PixelAdminApp;
