# -------------------------------------------------------------------
# plugins / file-input.coffee

###
 * @class FileInput
###

FileInput = ($input, options={}) ->
  @options = $.extend({}, FileInput.DEFAULTS, options || {})
  @$input = $input
  @$el = $('<div class="pixel-file-input"><span class="pfi-filename"></span><div class="pfi-actions"></div></div>').insertAfter($input).append($input)
  @$filename = $('.pfi-filename', @$el)
  @$clear_btn = $(@options.clear_btn_tmpl).addClass('pfi-clear').appendTo($('.pfi-actions', @$el))
  @$choose_btn = $(@options.choose_btn_tmpl).addClass('pfi-choose').appendTo($('.pfi-actions', @$el))

  @onChange()
  $input.on 'change', () =>
    $.proxy(@onChange, @)()
  .on 'click', (e) ->
    e.stopPropagation()

  @$el.on 'click', () ->
    $input.click()

  @$choose_btn.on 'click', (e) ->
    e.preventDefault()

  @$clear_btn.on 'click', (e) =>
    $input.wrap('<form>').parent('form').trigger('reset')
    $input.unwrap()
    $.proxy(@onChange, @)()
    e.stopPropagation()
    e.preventDefault()


FileInput.DEFAULTS =
  choose_btn_tmpl: '<a href="#" class="btn btn-xs btn-primary">Choose</a>'
  clear_btn_tmpl:  '<a href="#" class="btn btn-xs"><i class="fa fa-times"></i> Clear</a>'
  placeholder: null


FileInput.prototype.onChange = () ->
  value = @$input.val().replace(/\\/g, '/')
  if value isnt ''
    @$clear_btn.css('display', 'inline-block')
    @$filename.removeClass('pfi-placeholder')
    @$filename.text(value.split('/').pop())
  else
    @$clear_btn.css('display', 'none')
    if @options.placeholder
      @$filename.addClass('pfi-placeholder')
      @$filename.text(@options.placeholder)
    else
      @$filename.text('')


$.fn.pixelFileInput = (options) ->
  @each () ->
    $.data(@, 'pixelFileInput', new FileInput($(@), options)) unless $.data(@, 'pixelFileInput')

$.fn.pixelFileInput.Constructor = FileInput
