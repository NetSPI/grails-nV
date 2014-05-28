# -------------------------------------------------------------------
# plugins / tasks.coffee


Tasks = ($el, options={}) ->
  @$el = $el
  @options = $.extend({}, Tasks.DEFAULTS, options)

  self = @
  $el.on 'click', '.task input[type=checkbox]', ->
    self.completeTask($(@))
  .on 'click', '.task a', ->
    $(@).parents('.task').find('input[type=checkbox]').click()
    false
  @

Tasks.prototype.completeTask = ($trigger) ->
  $task = $trigger.parents('.task')
  if $task.toggleClass('completed').hasClass('completed')
    @options.onComplete.call(@)
  else
    @options.onCancel.call(@)

Tasks.prototype.clearCompletedTasks = () ->
  $('.completed', @$el).hide 200, () ->
    $(@).remove()
  @options.onClear.call(@)

Tasks.DEFAULTS =
  onComplete: () ->
  onCancel:   () ->
  onClear:    () ->

$.fn.pixelTasks = (options) ->
  $(@).each ->
    $this = $(@)
    pt = $.data(@, 'pixelTasks')
    if not pt
      $.data(@, 'pixelTasks', new Tasks($this, options))
    else if options is 'clearCompletedTasks'
      pt.clearCompletedTasks()

$.fn.pixelTasks.Constructor = Tasks
