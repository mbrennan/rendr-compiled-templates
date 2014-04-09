rendrDot = (options) ->
    options ?= {}
    options.basePath ?= 'spec/preCompiled'
    options.templatePath ?= 'templates'

    require('../src')(options)

module.exports =
  templateAdapter: rendrDot
  rendrDot: rendrDot

