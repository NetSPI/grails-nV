# -------------------------------------------------------------------
# components / main-menu.coffee
#

###
 * Class that provides the main menu functionality.
 *
 * @class MainMenu
###

PixelAdmin.MainMenu = ->
  @_screen = null
  @_last_screen = null
  @_animate = false
  @_close_timer = null
  @_dropdown_li = null
  @_dropdown = null
  @

###
 * Initialize plugin.
###
PixelAdmin.MainMenu.prototype.init = ->
  @$menu = $('#main-menu')
  return unless @$menu.length
  @$body = $('body')
  @menu = @$menu[0]
  @$ssw_point = $('#small-screen-width-point')
  @$tsw_point = $('#tablet-screen-width-point')
  self = @

  # Restore menu state
  if PixelAdmin.settings.main_menu.store_state
    state = @_getMenuState()
    document.body.className += ' disable-mm-animation'
    @$body[if state is 'collapsed' then 'addClass' else 'removeClass']('mmc') if state != null
    setTimeout =>
      elRemoveClass(document.body, 'disable-mm-animation')
    , 20

  # Setup animation
  @setupAnimation()

  # On window resize
  $(window).on 'resize.pa.mm', $.proxy(@onResize, @)
  @onResize()

  # Mark root elements
  @$menu.find('.navigation > .mm-dropdown').addClass('mm-dropdown-root')

  # Detect active item
  @detectActiveItem() if PixelAdmin.settings.main_menu.detect_active

  # Trigger resize event on main menu state change
  if $.support.transition
    @$menu.on 'transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd', $.proxy(@_onAnimationEnd, @)

  # Toggle button
  $('#main-menu-toggle').on 'click', $.proxy(@toggle, @)

  # Setup scroller
  $('#main-menu-inner').slimScroll({
    height: '100%'
  }).on 'slimscrolling', => @closeCurrentDropdown(true)

  # Bind click event on the dropdown toggle
  @$menu.on 'click', '.mm-dropdown > a', ->
    li = this.parentNode
    # li is a root and main menu is collapsed?
    if elHasClass(li, 'mm-dropdown-root') and self._collapsed()
      # Is dropdown menu already opened?
      if elHasClass(li, 'mmc-dropdown-open')
        if elHasClass(li, 'freeze')
          self.closeCurrentDropdown(true)
        else
          self.freezeDropdown(li)
      # Dropdown menu is closed
      else
        self.openDropdown(li, true)
    else
      self.toggleSubmenu(li)
    false

  # Open dropdown on mouse enter
  @$menu.find('.navigation').on 'mouseenter.pa.mm-dropdown', '.mm-dropdown-root', ->
    self.clearCloseTimer()
    return if self._dropdown_li is this
    if self._collapsed() and (not self._dropdown_li or not elHasClass(self._dropdown_li, 'freeze'))
      self.openDropdown(this)

  # Close dropdown on mouse leave
  .on 'mouseleave.pa.mm-dropdown', '.mm-dropdown-root', ->
    self._close_timer = setTimeout ->
      self.closeCurrentDropdown()
    , PixelAdmin.settings.main_menu.dropdown_close_delay
  @


PixelAdmin.MainMenu.prototype._collapsed = ->
  (@_screen is 'desktop' and elHasClass(document.body, 'mmc')) or (@_screen isnt 'desktop' and not elHasClass(document.body, 'mme'))


PixelAdmin.MainMenu.prototype.onResize = ->
  @_screen = getScreenSize(@$ssw_point, @$tsw_point)
  @_animate = PixelAdmin.settings.main_menu.disable_animation_on.indexOf(screen) is -1
  @closeCurrentDropdown(true) if @_dropdown_li

  if (@_screen is 'small' and @_last_screen isnt @_screen) or (@_screen is 'tablet' and @_last_screen is 'small')
    document.body.className += ' disable-mm-animation'
    setTimeout =>
      elRemoveClass(document.body, 'disable-mm-animation')
    , 20
  @_last_screen = @_screen


PixelAdmin.MainMenu.prototype.clearCloseTimer = ->
  if @_close_timer
    clearTimeout(@_close_timer)
    @_close_timer = null


PixelAdmin.MainMenu.prototype._onAnimationEnd = (e) ->
  return if @_screen isnt 'desktop' or e.target.id isnt 'main-menu'
  $(window).trigger('resize')


PixelAdmin.MainMenu.prototype.toggle = ->
  cls = if (@_screen is 'small' or @_screen is 'tablet') then 'mme' else 'mmc'
  if elHasClass(document.body, cls)
    elRemoveClass(document.body, cls)
  else
    document.body.className += ' ' + cls
  
  if cls is 'mmc'
    @_storeMenuState(elHasClass(document.body, 'mmc')) if PixelAdmin.settings.main_menu.store_state
    $(window).trigger('resize') unless $.support.transition
  else
    # Collapse main navigation bar
    collapse = document.getElementById('')
    $('#main-navbar-collapse').stop().removeClass('in collapsing').addClass('collapse')[0].style.height = '0px'
    $('#main-navbar .navbar-toggle').addClass('collapsed')


PixelAdmin.MainMenu.prototype.toggleSubmenu = (li) ->
  @[if elHasClass(li, 'open') then 'collapseSubmenu' else 'expandSubmenu'](li)
  false


PixelAdmin.MainMenu.prototype.collapseSubmenu = (li) ->
  $li = $(li)
  $ul = $li.find('> ul')

  if @_animate
    $ul.animate { height: 0 }, PixelAdmin.settings.main_menu.animation_speed, =>
      elRemoveClass(li, 'open')
      $ul.attr('style', '')
      $li.find('.mm-dropdown.open').removeClass('open').find('> ul').attr('style', '')
  else
    elRemoveClass(li, 'open')
  false


PixelAdmin.MainMenu.prototype.expandSubmenu = (li) ->
  $li = $(li)
  @collapseAllSubmenus(li) if PixelAdmin.settings.main_menu.accordion

  if @_animate
    $ul = $li.find('> ul')
    ul  = $ul[0]

    # Get UL height
    ul.className += ' get-height'
    h = $ul.height()
    elRemoveClass(ul, 'get-height')

    # Preparing to animation
    ul.style.display = 'block'
    ul.style.height  = '0px'
    li.className += ' open'

    $ul.animate { height: h }, PixelAdmin.settings.main_menu.animation_speed, =>
      $ul.attr('style', '')
  else
    li.className += ' open'


PixelAdmin.MainMenu.prototype.collapseAllSubmenus = (li) ->
  self = @
  $(li).parent().find('> .mm-dropdown.open').each -> self.collapseSubmenu(this)


PixelAdmin.MainMenu.prototype.openDropdown = (li, freeze=false) ->
  @closeCurrentDropdown(freeze) if @_dropdown_li
  $li = $(li)
  $ul = $li.find('> ul')
  ul = $ul[0]
  @_dropdown_li = li
  @_dropdown = ul

  $title = $ul.find('> .mmc-title')
  unless $title.length
    $title = $('<div class="mmc-title"></div>').text($li.find('> a > .mm-text').text())
    ul.insertBefore($title[0], ul.firstChild)

  li.className += ' mmc-dropdown-open'
  ul.className += ' mmc-dropdown-open-ul'

  top = $li.position().top

  # Initialize dropdown scroller if the main menu is fixed
  if elHasClass(document.body, 'main-menu-fixed')

    # Wrap menu items
    $wrapper = $ul.find('.mmc-wrapper')
    unless $wrapper.length
      # Append wrapper to the dropdown menu
      wrapper = document.createElement('div')
      wrapper.className = 'mmc-wrapper'
      wrapper.style.overflow = 'hidden'
      wrapper.style.position = 'relative'

      $wrapper = $(wrapper)
      $wrapper.append($ul.find('> li'))
      ul.appendChild(wrapper)

    # Get parameters
    w_height = $(window).innerHeight()
    title_h = $title.outerHeight()
    min_height = title_h + $ul.find('.mmc-wrapper > li').first().outerHeight() * 3

    # Bottom dropdown
    if (top + min_height) > w_height
      max_height = top - $('#main-navbar').outerHeight()
      ul.className += ' top'
      ul.style.bottom = (w_height - top - title_h) + 'px';
    # Top dropdown
    else
      max_height = w_height - top - title_h
      ul.style.top = top + 'px'

    if elHasClass(ul, 'top')
      ul.appendChild($title[0])
    else
      ul.insertBefore($title[0], ul.firstChild)

    li.className += ' slimscroll-attached';
    $wrapper[0].style.maxHeight = (max_height - 10) + 'px'
    $wrapper.pixelSlimScroll({})
  else
    ul.style.top = top + 'px';
  @freezeDropdown(li) if freeze

  unless freeze
    $ul.on 'mouseenter', =>
      @clearCloseTimer()
    .on 'mouseleave', =>
      @_close_timer = setTimeout =>
        @closeCurrentDropdown()
      , PixelAdmin.settings.main_menu.dropdown_close_delay
    @

  @menu.appendChild ul


PixelAdmin.MainMenu.prototype.closeCurrentDropdown = (force=false) ->
  return if not @_dropdown_li or (elHasClass(@_dropdown_li, 'freeze') and not force)
  @clearCloseTimer()

  $dropdown = $(@_dropdown)

  if elHasClass(@_dropdown_li, 'slimscroll-attached')
    elRemoveClass(@_dropdown_li, 'slimscroll-attached')
    $wrapper = $dropdown.find('.mmc-wrapper')
    $wrapper.pixelSlimScroll({ destroy: 'destroy' }).find('> *').appendTo($dropdown)
    $wrapper.remove()
  @_dropdown_li.appendChild @_dropdown

  elRemoveClass(@_dropdown, 'mmc-dropdown-open-ul')
  elRemoveClass(@_dropdown, 'top')
  elRemoveClass(@_dropdown_li, 'mmc-dropdown-open')
  elRemoveClass(@_dropdown_li, 'freeze')

  $(@_dropdown_li).attr('style', '')
  $dropdown.attr('style', '').off('mouseenter').off('mouseleave')

  @_dropdown = null
  @_dropdown_li = null


PixelAdmin.MainMenu.prototype.freezeDropdown = (li) ->
  li.className += ' freeze'


PixelAdmin.MainMenu.prototype.setupAnimation = ->
  d_body = document.body
  dsbl_animation_on  = PixelAdmin.settings.main_menu.disable_animation_on
  # Disable animation
  d_body.className += ' dont-animate-mm-content'

  $mm = $('#main-menu')
  $mm_nav = $mm.find('.navigation')

  $mm_nav.find('> .mm-dropdown > ul').addClass 'mmc-dropdown-delay animated'
  $mm_nav.find('> li > a > .mm-text').addClass  'mmc-dropdown-delay animated fadeIn'
  $mm.find('.menu-content').addClass 'animated fadeIn'
  
  if elHasClass(d_body, 'main-menu-right') or (elHasClass(d_body, 'right-to-left') and not elHasClass(d_body, 'main-menu-right'))
    $mm_nav.find('> .mm-dropdown > ul').addClass 'fadeInRight'
  else
    $mm_nav.find('> .mm-dropdown > ul').addClass 'fadeInLeft'

  # Small devices
  d_body.className += if dsbl_animation_on.indexOf('small') is -1 then ' animate-mm-sm' else ' dont-animate-mm-content-sm'

  # Tablets
  d_body.className += if dsbl_animation_on.indexOf('tablet') is -1 then ' animate-mm-md' else ' dont-animate-mm-content-md'

  # Desktops
  d_body.className += if dsbl_animation_on.indexOf('desktop') is -1 then ' animate-mm-lg' else ' dont-animate-mm-content-lg'

  # Enable animation
  window.setTimeout ->
    elRemoveClass(d_body, 'dont-animate-mm-content')
  , 500

PixelAdmin.MainMenu.prototype.detectActiveItem = ->
  url = (document.location+ '').replace(/\#.*?$/, '')
  predicate = PixelAdmin.settings.main_menu.detect_active_predicate
  nav = $('#main-menu .navigation')
  nav.find('li').removeClass('open active')
  links = nav[0].getElementsByTagName('a')
  
  bubble = (li) =>
    li.className += ' active'
    unless elHasClass(li.parentNode, 'navigation')
      li = li.parentNode.parentNode
      li.className += ' open'
      bubble(li)

  for a in links
    if a.href.indexOf('#') is -1 and predicate(a.href, url)
      bubble(a.parentNode)
      break

###
 * Load menu state.
###
PixelAdmin.MainMenu.prototype._getMenuState = ->
  PixelAdmin.getStoredValue(PixelAdmin.settings.main_menu.store_state_key, null)

###
 * Store menu state.
###
PixelAdmin.MainMenu.prototype._storeMenuState = (is_collapsed) ->
  return unless PixelAdmin.settings.main_menu.store_state
  PixelAdmin.storeValue(PixelAdmin.settings.main_menu.store_state_key, if is_collapsed then 'collapsed' else 'expanded')

PixelAdmin.MainMenu.Constructor = PixelAdmin.MainMenu
PixelAdmin.addInitializer ->
  # Initialize plugin.
  PixelAdmin.initPlugin 'main_menu', new PixelAdmin.MainMenu