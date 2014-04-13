module.exports = (options) ->
  options ?= {}
  options.basePath ?= __dirname
  options.templateDirectory ?= 'templates'
  options.commonModule = 'common/identity'
  options.serverModule = false

  require('../lib/rendr-compiled-templates.coffee')(options)

