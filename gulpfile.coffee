_       = require 'underscore'
del     = require 'del'
gulp    = require 'gulp'
plugins = require 'gulp-load-plugins'
url     = require 'url'

config  = require './config'
$$      = plugins()

addLinkTitle = ($) ->
  $ 'a'
    .each ->
      $a = $ @
      alt = $a.find 'img'
        .attr 'alt'
      return if typeof alt is 'undefined' or alt is ''
      $a.attr 'title', alt

addLinktarget = ($) ->
  $ 'a'
    .attr 'target', '_blank'

fixImage = ($) ->
  $ 'img'
    .css 'display', 'block'
    .attr 'border', 0

fixTable = ($) ->
  $ 'table'
    .attr 'border', 0
    .attr 'cellpadding', 0
    .attr 'cellspacing', 0

gulp.task 'html', ->
  gulp.src config.html.src
    .pipe $$.jade config.jade
    .pipe $$.cheerio addLinkTitle
    .pipe $$.cheerio addLinktarget
    .pipe $$.cheerio fixImage
    .pipe $$.cheerio fixTable
    .pipe $$.htmltidy config.tidy
    .pipe $$.replace 'us-ascii', 'UTF-8'
    .pipe gulp.dest config.html.dest
    .pipe $$.livereload()

gulp.task 'img', ->
  gulp.src config.img.src
    .pipe $$.newer config.img.dest
    .pipe $$.imagemin()
    .pipe gulp.dest config.img.dest
    .pipe $$.livereload()

gulp.task 'clean', (cb) ->
  del config.dest, cb

gulp.task 'watch', ->
  $$.livereload.listen()
  gulp.watch config.html.watch, ['html']
  gulp.watch config.img.watch, ['img']

gulp.task 'default', ['html', 'img']
