# -------------------------------------------------------------------
# extensions / bootstrap-tabdrop.coffee
#

throw new Error('bootstrap-tabdrop.js required') unless $.fn.tabdrop

tabdrop = $.fn.tabdrop

$.fn.tabdrop = (options) ->
  options = $.extend({}, $.fn.tabdrop.defaults, options)
  @each ->
    $this= $(@)
    tabdrop.call($this, options)
    data = $this.data('tabdrop')
    if data
      #$(data.dropdown).off("click")
      # Update tabdrop on tab click
      data.dropdown.on "click", "li", ->
        $(this).parent().parent().find("a.dropdown-toggle").empty().html('<span class="display-tab"> ' + $(this).text() + ' </span><b class="caret"></b>')
        data.layout()

      data.element.on 'click', '> li', ->
        return if $(@).hasClass('tabdrop')
        data.element.find("> .tabdrop > a.dropdown-toggle").empty().html(options.text + ' <b class="caret"></b>')
        data.layout()

$.fn.tabdrop.defaults = {
  text: '<i class="fa fa-bars"></i>'
};