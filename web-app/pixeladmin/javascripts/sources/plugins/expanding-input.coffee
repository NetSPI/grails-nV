# -------------------------------------------------------------------
# plugins / expanding-input.coffee

###
 * @class ExpandingInput
###

ExpandingInput = ($container, options={}) ->
  @options = $.extend({}, ExpandingInput.DEFAULTS, options || {})
  @$container = $container
  @$target = if @options.target and @$container.find(@options.target).length then @$container.find(@options.target) else null
  @$content = if @options.hidden_content and @$container.find(@options.hidden_content).length then @$container.find(@options.hidden_content) else null

  @$container.addClass('expanding-input')
  if @$target
    @$target.addClass('expanding-input-target')
    @$container.addClass('expanding-input-sm') if @$target.hasClass('input-sm')
    @$container.addClass('expanding-input-lg') if @$target.hasClass('input-lg')
  @$content.addClass('expanding-input-content') if @$content

  @$overlay = $('<div class="expanding-input-overlay"></div>').appendTo(@$container)
  if @$target and @$target.attr('placeholder')
    @options.placeholder = @$target.attr('placeholder') unless @options.placeholder
    @$target.attr('placeholder', '')
  @$overlay.append($('<div class="expanding-input-placeholder"></div>').html(@options.placeholder)) if @options.placeholder

  @$target.on('focus', $.proxy(@expand, @)) if @$target
  @$overlay.on('click.expanding_input', $.proxy(@expand, @))


ExpandingInput.prototype.expand = () ->
  return if @$container.hasClass('expanded')
  # Run before callback
  @options.onBeforeExpand.call(@) if @options.onBeforeExpand
  # Remove overlay
  @$overlay.remove()
  # Add class
  @$container.addClass('expanded')
  # Focus on input
  setTimeout(=>
    @$target.focus()
  , 1) if @$target
  @$target.attr('placeholder', $('<div>'+@options.placeholder+'</div>').text()) if @$target and @options.placeholder

  # Run after callback
  @options.onAfterExpand.call(@) if @options.onAfterExpand


ExpandingInput.DEFAULTS =
  target: null
  hidden_content: null
  placeholder: null
  onBeforeExpand: null
  onAfterExpand: null

$.fn.expandingInput = (options) ->
  @each () ->
    $this = $(@)
    $.data($this, 'expandingInput', new ExpandingInput($this, options)) unless $this.attr('data-expandingInput')

$.fn.expandingInput.Constructor = ExpandingInput
