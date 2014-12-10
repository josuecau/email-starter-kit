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
    locals:
      title: 'The title'
  tidy:
    #asciiChars: 1
    charEncoding: 'ascii'
    doctype: 'loose'
    outputEncoding: 'ascii'
    inputEncoding: 'utf8'
    #fixUri: false
    indent: 'auto'
    sortAttributes: 'alpha'
    wrap: 0
  tracking:
    params:
      utm_source: 'newsXXX'
      utm_medium: 'email'
      utm_content: 'newsXXXXXXXX'
    excludedHosts: ['facebook.com', 'twitter.com']
    excludedProtocols: ['mailto:']
