rendrDot = (options) ->
  path = require 'path'

  options ?= {}
  options.basePath ?= path.join __dirname, 'preCompiled'
  options.templatePath ?= 'templates'

  require('../lib/rendr-dot')(options)

module.exports =
  templateAdapter: rendrDot
  rendrDot: rendrDot

