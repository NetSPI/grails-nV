# -------------------------------------------------------------------
# utils.coffee
#

unless String.prototype.endsWith
  ###
   * Determines whether a string ends with the specified suffix.
   * 
   * @param  {String} suffix
   * @return Boolean
  ###
  String.prototype.endsWith = (suffix) ->
    @indexOf(suffix, @length - suffix.length) isnt -1

unless String.prototype.trim
  ###
   * Removes whitespace from both sides of a string.
   * 
   * @return {String}
  ###
  String.prototype.trim = ->
    @replace(/^\s+|\s+$/g, '')

unless Array.prototype.indexOf
  ###
   * The indexOf() method returns the first index at which a given element can be found in the array, or -1 if it is not present.
   * 
   * @param  {Variant} searchElement
   * @param  {Integer} fromIndex
   * @return {Integer}
  ###
  Array.prototype.indexOf = (searchElement, fromIndex) ->
    throw new TypeError('"this" is null or not defined') if @ is undefined or @ is null
    
    length = this.length >>> 0
    fromIndex = +fromIndex || 0
    fromIndex = 0 if Math.abs(fromIndex) is Infinity

    if fromIndex < 0
      fromIndex += length
      fromIndex = 0 if fromIndex < 0

    for i in [fromIndex...length]
      return i if @[i] is searchElement

    return -1

unless Function.prototype.bind
  Function.prototype.bind = (oThis) ->
    if typeof this isnt "function"
      # closest thing possible to the ECMAScript 5 internal IsCallable function
      throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable")

    aArgs = Array.prototype.slice.call(arguments, 1)
    fToBind = @
    fNOP = () ->
    fBound = () ->
      fToBind.apply((if (@ instanceof fNOP and oThis) then @ else oThis),
                    aArgs.concat(Array.prototype.slice.call(arguments)))

    fNOP.prototype = @prototype
    fBound.prototype = new fNOP()

    return fBound

# From https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys
unless Object.keys
  Object.keys = ((->
    'use strict'
    hasOwnProperty = Object.prototype.hasOwnProperty
    hasDontEnumBug = if ({toString: null}).propertyIsEnumerable('toString') then false else true
    dontEnums = [
      'toString',
      'toLocaleString',
      'valueOf',
      'hasOwnProperty',
      'isPrototypeOf',
      'propertyIsEnumerable',
      'constructor'
    ]

    return (obj) ->
      if typeof obj isnt 'object' and (typeof(obj) isnt 'function' or obj is null)
        throw new TypeError('Object.keys called on non-object')

      result = []

      for prop in obj
        if hasOwnProperty.call(obj, prop)
          result.push(prop)

      if hasDontEnumBug
        for dontEnum in dontEnums
          if hasOwnProperty.call(obj, dontEnum)
            result.push(dontEnum)
      result
  ).call(@))



###
 * Detect screen size.
 * 
 * @param  {jQuery Object} $ssw_point
 * @param  {jQuery Object} $tsw_point
 * @return {String}
###
window.getScreenSize = ($ssw_point, $tsw_point) ->
  if $ssw_point.is(':visible')
    return 'small'
  else if $tsw_point.is(':visible')
    return 'tablet'
  else
    return 'desktop'

window.elHasClass = (el, selector) ->
  (" " + el.className + " ").indexOf(" " + selector + " ") > -1

window.elRemoveClass = (el, selector) ->
  el.className = (" " + el.className + " ").replace(" " + selector + " ", ' ').trim()

