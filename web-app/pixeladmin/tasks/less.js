module.exports = function (css_src, css_dest) {
  return {
    build: {
      options: {
        paths: [css_src]
      },
      files: [
        {
          dest: css_dest + 'bootstrap.css',
          src:  [css_src + 'libs/bootstrap-3.*/bootstrap.less']
        },
        {
          dest: css_dest + 'pixel-admin.css',
          src:  [css_src + 'pixel-admin.less']
        },
        {
          dest: css_dest + 'widgets.css',
          src:  [css_src + 'pixel-admin-less/widgets/widgets.less']
        },
        {
          dest: css_dest + 'pages.css',
          src:  [css_src + 'pixel-admin-less/pages/pages.less']
        },
        {
          dest: css_dest + 'themes.css',
          src:  [css_src + 'pixel-admin-less/themes/themes.less']
        },
        {
          dest: css_dest + 'rtl.css',
          src:  [css_src + 'pixel-admin-less/rtl/rtl.less']
        }
      ]
    }
  }
}
