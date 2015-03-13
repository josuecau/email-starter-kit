src  = 'src'
dest = 'build'

module.exports =
  src: src
  dest: dest + '/**'
  html:
    src: [src + '/jade/**/*.jade', '!' + src + '/jade/**/_*.jade']
    dest: dest
    watch: src + '/jade/**/*.jade'
  img:
    src: [src + '/img/**/*.jpg', src + '/img/**/*.gif']
    dest: dest + '/img'
    watch: [src + '/img/**/*.jpg', src + '/img/**/*.gif']
  jade:
    pretty: true
    locals: {}
  tidy:
    charEncoding: 'ascii'
    doctype: 'loose'
    outputEncoding: 'ascii'
    inputEncoding: 'utf8'
    indent: 'auto'
    sortAttributes: 'alpha'
    wrap: 0
