rendrDot = (options) ->
  options ?= {}
  options.basePath ?= __dirname
  options.templatePath ?= 'templates'

  require('../lib/rendr-dot')(options)

module.exports =
  templateAdapter: rendrDot
  rendrDot: rendrDot

