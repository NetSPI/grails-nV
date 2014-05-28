# -------------------------------------------------------------------
# extensions / jquery-ui.datepicker.coffee
#

throw new Error('jquery.ui.datepicker.js required') if (!window.JQUERY_UI_EXTRAS_LOADED || !$.fn.datepicker)

datepicker = $.fn.datepicker
$.fn.datepicker = (options) ->
  datepicker.call @, $.extend({isRTL: $('body').hasClass('right-to-left')}, options || {})
