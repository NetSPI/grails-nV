module.exports = function (css_dest) {
  return {
    minify: {
      expand: true,
      cwd: css_dest,
      src: ['*.css', '!*.min.css'],
      dest: css_dest,
      ext: '.min.css'
    }
  }
}