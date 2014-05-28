var paths = {
  html_dir: 'html/',

  js_src:   'javascripts/',
  js_dest:  'html/assets/javascripts/',

  css_src:  'styles/',
  css_dest: 'html/assets/stylesheets/'
}

module.exports = function(grunt) {

  /*  Load tasks  */

  require('load-grunt-tasks')(grunt);

  /*  Configure project  */

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    // Setup tasks
    htmlhint: require('./tasks/htmlhint')(paths.html_dir),
    coffee:   require('./tasks/coffee')(paths.js_src),
    concat:   require('./tasks/concat')(paths.js_src, paths.js_dest),
    uglify:   require('./tasks/uglify')(paths.js_dest),
    less:     require('./tasks/less')(paths.css_src, paths.css_dest),
    sass:     require('./tasks/sass')(paths.css_src, paths.css_dest),
    cssmin:   require('./tasks/cssmin')(paths.css_dest),
    watch:    require('./tasks/watch')(paths.js_src, paths.css_src),
  });
  
  /*  Register tasks  */
  
  // Default task.
  grunt.registerTask('default', ['coffee:compile', 'concat:build', 'uglify:minify', 'less:build', 'cssmin:minify']);

  grunt.registerTask('build-project-sass', ['coffee:compile', 'concat:build', 'uglify:minify', 'sass:build', 'cssmin:minify']);

  grunt.registerTask('compile-less', ['less:build', 'cssmin:minify']);

  grunt.registerTask('compile-sass', ['sass:build', 'cssmin:minify']);

  grunt.registerTask('compile-js', ['coffee:compile', 'concat:build', 'uglify:minify']);
};
