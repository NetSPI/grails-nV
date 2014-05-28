module.exports = function (js_src, css_src) {
  return {
    js: {
      files: [
        js_src + '**/*.coffee',
        js_src + '**/*.js',
        '!' + js_src + 'build/*.js',
      ],
      tasks: ['coffee:compile', 'concat:build', 'uglify:minify']
    },

    less: {
      files: [
        css_src + '*.less',
        css_src + '**/*.less'
      ],
      tasks: ['less:build', 'cssmin:minify']
    },

    sass: {
      files: [
        css_src + '*.scss',
        css_src + '**/*.scss'
      ],
      tasks: ['sass:build', 'cssmin:minify']
    }
  }
}
