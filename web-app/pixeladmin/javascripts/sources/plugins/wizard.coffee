# -------------------------------------------------------------------
# plugins / wizard.coffee


setElementWidth = ($el, width) ->
  $el.css
    'width':     width
    'max-width': width
    'min-width': width


###
 * @class Wizard
###

Wizard = ($element, options={}) ->
  @options       = $.extend({}, Wizard.DEFAULTS, options || {})
  @$element      = $element
  @$wrapper      = $('.wizard-wrapper', @$element)
  @$steps        = $('.wizard-steps', @$wrapper)
  @$step_items   = $('> li', @$steps)
  @steps_count   = @$step_items.length
  @$content      = $('.wizard-content', @$element)
  @current_step  = null
  @$current_item = null
  @isFreeze = false
  @isRtl = $('body').hasClass('right-to-left')
  
  @resizeStepItems()

  $cur_step = $('> li.active', @$steps)
  $cur_step = $('> li:first-child', @$steps) if $cur_step.length is 0
  
  @$current_item = $cur_step.addClass('active')
  @current_step  = $cur_step.index() + 1

  $($cur_step.attr('data-target'), @$content).css({ display: 'block' })
  @placeStepItems()
  @_setPrevItemStates(@current_step - 1)

  $(window).on 'pa.resize.wizard', =>
    $.proxy(@resizeStepItems, @)()
    $.proxy(@placeStepItems, @)()

  self = @
  @$steps.on 'click', '> li', ->
    $this = $(@)
    self.setCurrentStep($this.index() + 1) if $this.hasClass('completed')
  @

#Defaults
Wizard.DEFAULTS =
  step_item_min_width: 200
  onChange: null
  onFinish: null

###
 * Resize steps
###
Wizard.prototype.resizeStepItems = ->
  if @$element.width() > (Wizard.DEFAULTS.step_item_min_width * @$step_items.length)
    width = Math.floor(@$element.width() / @$step_items.length)
  else
    width = Wizard.DEFAULTS.step_item_min_width
  @$step_items.each -> setElementWidth $(@), width

###
 * Move steps
###
Wizard.prototype.placeStepItems = ->
  offset             = 0
  item_position      = @$current_item.position()
  element_width      = @$element.outerWidth()
  steps_width        = @$steps.outerWidth()
  current_item_width = @$current_item.outerWidth()
  d                  = (element_width - current_item_width) / 2

  if not @isRtl
    if element_width < steps_width && item_position.left > d
      offset = -1 * item_position.left + d
      offset = -1 * steps_width + element_width if (steps_width + offset) < element_width
    @$steps.css({ left: offset })
  else
    item_position_right = steps_width - item_position.left - current_item_width
    if element_width < steps_width && item_position_right > d
      offset = -1 * item_position_right + d
      offset = -1 * steps_width + element_width if (steps_width + offset) < element_width
    @$steps.css({ right: offset })

###
 * Change step
 *
 * @param {Integer} step
###
Wizard.prototype.setCurrentStep = (step) ->
  return if @isFreeze
  $(@$current_item.attr('data-target'), @$content).css({ opacity: 1 }).animate({ opacity: 0 }, 200, =>
    $(@$current_item.attr('data-target'), @$content).attr('style', '')

    @_clearItemStates(step - 1)
    @$current_item = @$step_items.eq(step - 1).addClass('active')
    @current_step = step
    @_setPrevItemStates(step - 1)
    $(@$current_item.attr('data-target'), @$content).css({ display: 'block', opacity: 0 }).animate({ opacity: 1 }, 200, =>
      $.proxy(@options.onChange, @)() if @options.onChange
      @placeStepItems()
    )
  )

###
 * Move to next step
###
Wizard.prototype.nextStep = ->
  return if @isFreeze
  if @current_step >= @steps_count
    $.proxy(@options.onFinish, @)() if @options.onFinish
    return
  @$current_item.removeClass('active').addClass('completed')
  @setCurrentStep(@current_step + 1)

###
 * Move to previous step
###
Wizard.prototype.prevStep = ->
  return if @isFreeze
  return if @current_step <= 1
  @setCurrentStep(@current_step - 1)

###
 * Get current step
###
Wizard.prototype.currentStep = ->
  @current_step

###
 * @param {Integer} start_index
###
Wizard.prototype._clearItemStates = (start_index) ->
  for i in [start_index...@steps_count]
    @$step_items.eq(i).removeClass('active').removeClass('completed')

###
 * @param {Integer} end_index
###
Wizard.prototype._setPrevItemStates = (end_index) ->
  for i in [0...end_index]
    @$step_items.eq(i).addClass('completed')

###
 * Freeze wizard
###
Wizard.prototype.freeze = ->
  @isFreeze = true
  @$element.addClass('freeze')

###
 * Unfreeze wizard
###
Wizard.prototype.unfreeze = ->
  @isFreeze = false
  @$element.removeClass('freeze')

###
 * jQuery Wizard plugin initialization
 *
 * @param {Object|String} options
 * @param {Object} attrs
###
$.fn.pixelWizard = (options, attrs) ->
  methodReturn = undefined
  $set = @.each ->
    $this = $(@)

    if not $.data(this, 'pixelWizard')
      $.data(this, 'pixelWizard', new Wizard($this, options))
    else if options and typeof(options) is 'string'
      wizard_obj = $.data(this, 'pixelWizard')

      if options is 'setCurrentStep'
        wizard_obj.setCurrentStep(attrs)
      else if options is 'currentStep'
        methodReturn = wizard_obj.currentStep()
      else if options is 'nextStep'
        wizard_obj.nextStep()
      else if options is 'prevStep'
        wizard_obj.prevStep()
      else if options is 'freeze'
        wizard_obj.freeze()
      else if options is 'unfreeze'
        wizard_obj.unfreeze()
      else if options is 'resizeSteps'
        wizard_obj.resizeStepItems()

  return (if methodReturn is undefined then $set else methodReturn)

$.fn.pixelWizard.Constructor = Wizard
