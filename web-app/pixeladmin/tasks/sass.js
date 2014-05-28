module.exports = function (css_src, css_dest) {
  return {
    build: {
      files: [
        {
          dest: css_dest + 'bootstrap.css',
          src:  [css_src + 'bootstrap.scss']
        },
        {
          dest: css_dest + 'pixel-admin.css',
          src:  [css_src + 'pixel-admin.scss']
        },
        {
          dest: css_dest + 'widgets.css',
          src:  [css_src + 'pixel-admin-scss/widgets/widgets.scss']
        },
        {
          dest: css_dest + 'pages.css',
          src:  [css_src + 'pixel-admin-scss/pages/pages.scss']
        },
        {
          dest: css_dest + 'themes.css',
          src:  [css_src + 'pixel-admin-scss/themes/themes.scss']
        },
        {
          dest: css_dest + 'rtl.css',
          src:  [css_src + 'pixel-admin-scss/rtl/rtl.scss']
        }
      ]
    }
  }
}
