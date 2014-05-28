module.exports = function (js_src, js_dest) {
  var paths = function (srcs) {
    for (var i = 0, l = srcs.length; i < l; i++) srcs[i] = js_src + srcs[i];
    return srcs;
  }

  return {
    build: {
      options: {
        separator: ';\n',
      },
      files: [
        // Bootstrap
        {
          dest: js_dest + 'bootstrap.js',
          src: paths([
          	'libs/bootstrap-3.1.1/transition.js',
            'libs/bootstrap-3.1.1/alert.js',
            'libs/bootstrap-3.1.1/button.js',
            'libs/bootstrap-3.1.1/carousel.js',
            'libs/bootstrap-3.1.1/collapse.js',
            'libs/bootstrap-3.1.1/dropdown.js',
            'libs/bootstrap-3.1.1/modal.js',
            'libs/bootstrap-3.1.1/tooltip.js',
            'libs/bootstrap-3.1.1/popover.js',
            'libs/bootstrap-3.1.1/scrollspy.js',
            'libs/bootstrap-3.1.1/tab.js',
            'libs/bootstrap-3.1.1/affix.js'
          ])
        },

        // PixelAdmin
        {
          dest: js_dest + 'pixel-admin.js',
          src: paths([

            // PixelAdmin App
            'build/utils.js',
            'build/app.js',
            'build/events.js',

            // Touch devices
            'libs/fastclick-0.6.11.js',
            'libs/jquery.event.move-1.3.6.js',
            'libs/jquery.event.swipe-0.5.js',

            // External plugins
            'libs/jquery.vague-0.0.4.js',
            'libs/select2-3.4.5/select2.js',

            // jQuery UI
            'libs/jquery-ui-1.10.4/jquery.ui.core.js',
            'libs/jquery-ui-1.10.4/jquery.ui.widget.js',
            'libs/jquery-ui-1.10.4/jquery.ui.mouse.js',
            'libs/jquery-ui-1.10.4/jquery.ui.position.js',
            'libs/jquery-ui-1.10.4/jquery.ui.sortable.js',
            'libs/jquery-ui-1.10.4/jquery.ui.slider.js',
            'libs/jquery-ui-1.10.4/jquery.ui.accordion.js',
            'libs/jquery-ui-1.10.4/jquery.ui.menu.js',
            'libs/jquery-ui-1.10.4/jquery.ui.autocomplete.js',
            'libs/jquery-ui-1.10.4/jquery.ui.spinner.js',
            'libs/jquery-ui-1.10.4/jquery.ui.progressbar.js',
            'libs/jquery-ui-1.10.4/jquery.ui.tabs.js',

            // PixelAdmin App Components and Plugins
            'build/components_main-navbar.js',
            'build/components_main-menu.js',
            'build/components_alert.js',
            'build/plugins_switcher.js',
            'build/plugins_limiter.js',
            'build/plugins_expanding-input.js',
            'build/plugins_wizard.js',
            'build/plugins_file-input.js',
            'build/plugins_tasks.js',
            'build/plugins_rating.js',
            'libs/pixel-slimscroll.js', // Slimscroll, optimized for the main menu dropdowns / Navbar collapse

            // Plugins
            'libs/bootstrap-datepicker-1.3.0/bootstrap-datepicker.js',
            'libs/bootstrap-timepicker-0.2.5.js',
            
            'libs/bootstrap-tabdrop.js',
            'libs/jquery.minicolors-2.1.1.js',
            'libs/jquery.maskedinput-1.3.1.js',
            'libs/jquery.autosize-1.18.4.js',
            'libs/bootbox.min-4.2.0.js',
            'libs/jquery.growl-1.1.5.js',
            'libs/jquery.knob-1.2.7.js',
            'libs/jquery.sparkline-2.1.2.js',
            'libs/jquery.easypiechart-2.1.5.js',
            'libs/jquery.slimscroll-1.3.2.js',
            // {
              'libs/moment-2.5.1.js',
              'libs/bootstrap-datepaginator-1.1.0.js',
            // }
            // {
              'libs/bootstrap-editable-1.5.1/bootstrap-editable.js',
              'libs/bootstrap-editable-1.5.1/inputs-ext/address/address.js',
              'libs/bootstrap-editable-1.5.1/inputs-ext/typeaheadjs/lib/typeahead.js',
              'libs/bootstrap-editable-1.5.1/inputs-ext/typeaheadjs/typeaheadjs.js',
            // }
            // {
              'libs/jquery.validate-1.11.1/jquery.validate.js',
              'libs/jquery.validate-1.11.1/additional-methods.js',
            // }
            // {
              'libs/jquery-datatables-1.10.0/jquery.datatables.js',
              'libs/jquery-datatables-1.10.0/datatables.bootstrap3.js',
            // }
            // {
              'libs/dropzone-amd-module-3.8.4.js',
              'libs/dropzone-3.8.4.js',
            // }
            // {
              'libs/summernote-0.5.1/summernote.js',
            // }
            // {
              'libs/bootstrap-markdown-2.2.1/markdown.js',
              'libs/bootstrap-markdown-2.2.1/to-markdown.js',
              'libs/bootstrap-markdown-2.2.1/bootstrap-markdown.js',
            // }
            // {
              'libs/raphael-2.1.2.min.js',
              'libs/morris-0.5.0.js',
            // }
            // {
              'libs/jquery.flot-0.8.2/jquery.flot.js',
              'libs/jquery.flot-0.8.2/jquery.flot.pie.js',
              'build/plugins_flot.js',
            // }


            // PixelAdmin Extensions
            'build/extensions_modal.js',
            'build/extensions_bootstrap-datepicker.js',
            'build/extensions_bootstrap-timepicker.js',
            'build/extensions_bootstrap-datepaginator.js',
            'build/extensions_bootstrap-tabdrop.js',
            'build/extensions_jquery.validate.js',
            'build/extensions_jquery.knob.js',
            'build/extensions_jquery.sparklines.js',
          ])
        },

        // jQuery UI Extras
        {
          dest: js_dest + 'jquery-ui-extras.js',
          src: paths([
            'build/extensions_jquery-ui-extras.js', // This line is required
            'libs/jquery-ui-1.10.4/jquery.ui.tooltip.js',
            'libs/jquery-ui-1.10.4/jquery.ui.datepicker.js',
            'build/extensions_jquery-ui.datepicker.js'
          ])
        },

        // IE
        {
          dest: js_dest + 'ie.js',
          src: paths([
            'libs/respond.min.js',
            'libs/excanvas.js'
          ])
        }
      ],
    }
  }
}
