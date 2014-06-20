gulp     = require 'gulp'
gutil    = require 'gulp-util'
htmltidy = require 'gulp-htmltidy'
imagemin = require 'gulp-imagemin'
cheerio  = require 'gulp-cheerio'
cache    = require 'gulp-cached'
path     = require 'path'
url      = require 'url'
fs       = require 'fs'
util     = require 'util'
_        = require 'underscore'
config   = require './config'

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

checkImage = ($) ->
  $ 'img'
    .each ->
      $img = $ @
      src = $img.attr 'src'
      resolve = path.resolve config.paths.src, src
      fs.exists resolve, (exists) ->
        if !exists
          gutil.log util.format 'Image File "%s" not found', src
          return gutil.beep()
        extension = path.extname resolve
        if !_.contains config.images.extensions, extension
          gutil.log util.format 'Unexpected format "%s" for image "%s"', extension, src
          return gutil.beep()

gulp.task 'html', ->
  gulp.src path.join config.paths.src, '*.html'
  .pipe cheerio addLinkTitle
  .pipe cheerio addlinktarget
  .pipe cheerio addTracking
  .pipe cheerio fixImage
  .pipe cheerio checkImage
  .pipe htmltidy config.tidy
  .pipe gulp.dest config.paths.dest

gulp.task 'img', ->
  gulp.src path.join config.paths.src, 'img/*'
  .pipe cache 'img'
  .pipe imagemin()
  .pipe gulp.dest path.join config.paths.dest, 'img'

gulp.task 'default', ['html', 'img']
