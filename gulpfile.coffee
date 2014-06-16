gulp     = require 'gulp'
htmltidy = require 'gulp-htmltidy'
imagemin = require 'gulp-imagemin'
tools    = require 'gulp-emailing-tools'
path     = require 'path'

paths = 
  src: path.join __dirname, 'src'
  dest: path.join __dirname, 'dist'

tracking =
  utm_source: 'newsXXX'
  utm_medium: 'email'
  utm_content: 'newsXXXXXXXX'

gulp.task 'html', ->
  gulp.src path.join paths.src, '*.html'
  .pipe tools.addLinkTitle()
  .pipe tools.addLinkTarget()
  .pipe tools.addTracking tracking
  .pipe tools.fixImage()
  .pipe htmltidy
    #asciiChars: 1
    charEncoding: 'ascii'
    #outputEncoding: 'ascii'
    inputEncoding: 'utf8'
    #fixUri: false
    indent: 'auto'
    sortAttributes: 'alpha' 
    wrap: 0
  .pipe gulp.dest paths.dest

gulp.task 'img', ->
  gulp.src path.join paths.src, 'img/*'
  .pipe imagemin()
  .pipe gulp.dest path.join paths.dest, 'img'

gulp.task 'default', ['html', 'img']
