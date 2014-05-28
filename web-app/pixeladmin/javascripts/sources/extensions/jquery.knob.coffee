# -------------------------------------------------------------------
# extensions / jquery.knob.coffee
#

throw new Error('jquery.knob.js required') if not $.fn.knob

knob = $.fn.knob
$.fn.knob = (o) ->
  $body = $('body')
  knob.call(@, o).each ->
    if $body.hasClass('right-to-left')
      $input = $(@).find('input')
      $input.css
        'margin-left': 0
        'margin-right': $input.css('margin-left')