_       = require 'underscore'
fs      = require 'fs'
gulp    = require 'gulp'
path    = require 'path'
plugins = require 'gulp-load-plugins'
url     = require 'url'
util    = require 'util'

config  = require './config'
paths   = config.paths
$$      = plugins()

addLinkTitle = ($) ->
  $ 'a'
    .each ->
      $a = $ @
      alt = $a.find 'img'
        .attr 'alt'
      return if typeof alt is 'undefined' or alt is ''
      $a.attr 'title', alt

addlinktarget = ($) ->
  $ 'a'
    .attr 'target', '_blank'

addTracking = ($) ->
  return if not config.tracking?
  $ 'a'
    .each ->
      $a = $ @
      href = $a.attr 'href'
      return if typeof href is 'undefined' or href is ''
      parsed = url.parse href, true
      return if _.contains config.tracking.excludedHosts, parsed.host
      return if _.contains config.tracking.excludedProtocols, parsed.protocol
      if _.isEmpty parsed.query
        parsed.query = config.tracking.params
      else
        _.extend parsed.query, config.tracking.params
      parsed = _.omit parsed, 'search'
      formated = url.format parsed
      $a.attr 'href', formated

fixImage = ($) ->
  $ 'img'
    .css 'display', 'block'
    .attr 'border', 0

fixTable = ($) ->
  $ 'table'
    .attr 'border', 0
    .attr 'cellpadding', 0
    .attr 'cellspacing', 0

checkImage = ($) ->
  $ 'img'
    .each ->
      $img = $ @
      src = $img.attr 'src'
      resolve = path.resolve 'src', src
      fs.exists resolve, (exists) ->
        if !exists
          $$.util.log util.format 'Image File "%s" not found', src
          return $$.util.beep()
        extension = path.extname resolve
        if !_.contains config.images.extensions, extension
          $$.util.log util.format 'Unexpected format "%s"
          for image "%s"', extension, src
          return $$.util.beep()

gulp.task 'html', ->
  gulp.src paths.html.src
  .pipe $$.jade config.template
  .pipe $$.cheerio addLinkTitle
  .pipe $$.cheerio addlinktarget
  .pipe $$.cheerio addTracking
  .pipe $$.cheerio fixImage
  .pipe $$.cheerio fixTable
  .pipe $$.cheerio checkImage
  .pipe $$.htmltidy config.tidy
  .pipe $$.replace 'us-ascii', 'UTF-8'
  .pipe gulp.dest paths.html.dest
  .pipe $$.livereload()

gulp.task 'img', ->
  gulp.src paths.img.src
  .pipe $$.cached 'img'
  .pipe $$.imagemin()
  .pipe gulp.dest paths.img.dest
  .pipe $$.livereload()

gulp.task 'watch', ->
  $$.livereload.listen()
  gulp.watch paths.html.watch, ['html']
  gulp.watch paths.img.watch, ['img']

gulp.task 'default', ['html', 'img']
