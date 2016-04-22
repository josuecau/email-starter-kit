const src = 'src';
const dest = 'build';

module.exports = {
  src: src,
  dest: dest + '/**',
  html: {
    src: [src + '/views/**/*.pug', '!' + src + '/views/**/_*.pug'],
    dest: dest,
    watch: src + '/views/**/*.pug'
  },
  img: {
    src: [src + '/img/**/*.jpg', src + '/img/**/*.gif'],
    dest: dest + '/img',
    watch: [src + '/img/**/*.jpg', src + '/img/**/*.gif']
  },
  pug: {
    pretty: true,
    locals: {}
  },
  tidy: {
    charEncoding: 'ascii',
    doctype: 'loose',
    outputEncoding: 'ascii',
    inputEncoding: 'utf8',
    indent: 'auto',
    sortAttributes: 'alpha',
    wrap: 0
  }
};
