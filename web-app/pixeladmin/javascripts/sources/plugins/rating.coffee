# -------------------------------------------------------------------
# plugins / rating.coffee


Rating = ($el, options={}) ->
  @options = $.extend({}, Rating.DEFAULTS, options)
  @$container = $('<ul class="widget-rating"></ul>')
  @$container.append($('<li><a href="#" title="" class="widget-rating-item"></a></li>')) for i in [0...@options.stars_count]

  $el.append(@$container)

  self = @
  @$container.find('a').on 'mouseenter', ->
    self.$container.find('li').removeClass(self.options.class_active)
    $(@).parents('li').addClass(self.options.class_active).prevAll('li').addClass(self.options.class_active)

  .on 'mouseleave', ->
    self.setRating(self.options.rating)

  .on 'click', ->
    self.options.onRatingChange.call(self, $(@).parents('li').prevAll('li').length + 1)
    false
  @setRating(@options.rating)
  @

Rating.prototype.setRating = (value) ->
  @options.rating = value
  if (value - Math.floor(value)) > @options.lower_limit
    value = Math.ceil(value)
  else
    value = Math.floor(value)
  @$container.find('li').removeClass(@options.class_active).slice(0, value).addClass(@options.class_active)
  

Rating.DEFAULTS =
  stars_count: 5
  rating: 0
  class_active: 'active'
  lower_limit: 0.35
  onRatingChange: (value) ->

$.fn.pixelRating = (options, args) ->
  $(@).each ->
    $this = $(@)
    pr = $.data(@, 'pixelRating')
    if not pr
      $.data(@, 'pixelRating', new Rating($this, options))
    else if options is 'setRating'
      pr.setRating(args)

$.fn.pixelRating.Constructor = Rating

