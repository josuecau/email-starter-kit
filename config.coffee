module.exports =
  paths:
    all:
      src: 'src/**'
      dest: 'build/**'
    html:
      src: ['src/**/*.jade', '!src/jade/**/_*.jade']
      dest: 'build'
      watch: 'src/**.jade'
    img:
      src: 'src/img/**'
      dest: 'build/img'
      watch: 'src/img/**'
  images:
    extensions: ['.jpg', '.gif']
  template:
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
  tracking: false
    #params:
      #utm_source: 'newsXXX'
      #utm_medium: 'email'
      #utm_content: 'newsXXXXXXXX'
    #excludedHosts: ['facebook.com', 'twitter.com']
    #excludedProtocols: ['mailto:']
