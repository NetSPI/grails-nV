# -------------------------------------------------------------------
# extensions / bootstrap-datepaginator.coffee
#

throw new Error('bootstrap-datepaginator.js required') if not $.fn.datepaginator

datepaginator = $.fn.datepaginator

$.fn.datepaginator = (options, args) ->
  datepaginator.call(@, $.extend({},
    injectStyle: false
    itemWidth: 45
    selectedItemWidth: 160
  , options || {}), args)
