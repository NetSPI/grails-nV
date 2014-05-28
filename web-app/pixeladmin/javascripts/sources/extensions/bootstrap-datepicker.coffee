# -------------------------------------------------------------------
# extensions / jquery-ui.datepicker.coffee
#

throw new Error('bootstrap-datepicker.js required') if not $.fn.datepicker

datepicker = $.fn.datepicker
$.fn.datepicker = (options) ->
  options = $.extend({rtl: $('body').hasClass('right-to-left')}, options || {})
  datepicker.call $(@), options
