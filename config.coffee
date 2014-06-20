path = require 'path'

module.exports =
  images:
    extensions: ['.jpg', '.gif']
  paths:
    src: path.join __dirname, 'src'
    dest: path.join __dirname, 'build'
  tidy:
    #asciiChars: 1
    charEncoding: 'ascii'
    doctype: 'loose'
    #outputEncoding: 'ascii'
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
