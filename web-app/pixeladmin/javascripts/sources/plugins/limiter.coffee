# -------------------------------------------------------------------
# plugins / limiter.coffee

###
 * @class Limiter
###

Limiter = ($el, limit, options={}) ->
  @limit = limit
  @$el = $el
  @options = $.extend({}, Limiter.DEFAULTS, options || {})
  @$label = if @options.label and $(@options.label).length then $('.limiter-count', @options.label) else null
  @textarea = @$el.is('textarea');
  
  @$el.attr 'maxlength', @limit unless @textarea

  @$el.on "keyup focus", $.proxy(@updateCounter, @)
  @updateCounter()

Limiter.prototype.updateCounter = () ->
  input_value = if @textarea then @$el[0].value.replace( /\r?\n/g, "\n" ) else @$el.val()
  chars_count = input_value.length

  if chars_count > @limit
    @$el.val(input_value.substr(0, @limit))
    chars_count = @limit

  if @$label
    @$label.html(@limit - chars_count)

Limiter.DEFAULTS =
  label: null

$.fn.limiter = (limit, options) ->
  @each () ->
    $this = $(@)
    $.data($this, 'limiter', new Limiter($this, limit, options)) unless $this.attr('data-limiter')

$.fn.limiter.Constructor = Limiter
