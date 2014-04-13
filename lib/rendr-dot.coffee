path = require 'path'


module.exports = (options) ->
  options ?= Object.new
  options.basePath ?= ''
  options.templateDirectory ?= path.join 'app', 'templates'
  options.commonTemplates ?= 'commonTemplates'
  options.serverTemplates ?= 'serverTemplates'
  options.templates ?= Object.new
  options.isServer = not window?

  loadTemplatesFrom = (moduleName) ->
    modulePath = path.join options.basePath, options.templateDirectory, moduleName
    theseTemplates = require modulePath
    options.templates[templateName] = theseTemplates[templateName] for templateName of theseTemplates

  loadTemplatesFrom(options.commonTemplates) if options.commonTemplates
  loadTemplatesFrom(options.serverTemplates) if options.serverTemplates

  require('./compiledTemplateAdapter.coffee')(options.isServer)

