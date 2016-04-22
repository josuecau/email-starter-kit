const del = require('del');
const gulp = require('gulp');
const plugins = require('gulp-load-plugins');
const styleAttr = require('style-attr');
const config = require('./config');

const $$ = plugins();

const addLinkTitle = ($) => {
  return $('a').each((index, el) => {
    var $a = $(el);
    var alt = $a.find('img').attr('alt');
    if (typeof alt === 'undefined' || alt === '') {
      return;
    }
    return $a.attr('title', alt);
  });
};

const addLinktarget = ($) => {
  return $('a').attr('target', '_blank');
};

const fixImage = ($) => {
  return $('img').css('display', 'block').attr('border', 0);
};

const fixTable = ($) => {
  return $('table').attr({
    'border': 0,
    'cellpadding': 0,
    'cellspacing': 0
  });
};

const normalizeStyle = ($) => {
  return $('[style]').each((index, el) => {
    var $el = $(el);
    var styles = styleAttr.parse($el.attr('style'));
    $el.css(styles);
  });
};

gulp.task('html', () => {
  return gulp.src(config.html.src)
    .pipe($$.pug(config.pug))
    .pipe($$.cheerio(addLinkTitle))
    .pipe($$.cheerio(addLinktarget))
    .pipe($$.cheerio(fixImage))
    .pipe($$.cheerio(fixTable))
    .pipe($$.cheerio(normalizeStyle))
    .pipe($$.htmltidy(config.tidy))
    .pipe($$.replace('us-ascii', 'UTF-8'))
    .pipe(gulp.dest(config.html.dest))
    .pipe($$.livereload());
});

gulp.task('img', () => {
  return gulp.src(config.img.src)
    .pipe($$.newer(config.img.dest))
    .pipe($$.imagemin())
    .pipe(gulp.dest(config.img.dest))
    .pipe($$.livereload());
});

gulp.task('clean', (cb) => {
  return del(config.dest, cb);
});

gulp.task('watch', ['default'], () => {
  $$.livereload.listen();
  gulp.watch(config.html.watch, ['html']);
  return gulp.watch(config.img.watch, ['img']);
});

gulp.task('default', ['html', 'img']);
