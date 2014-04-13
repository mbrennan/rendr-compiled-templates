path = require 'path'


class CompiledTemplateAdapter
  constructor: (@templates) ->

  getTemplate: (templateName) ->
    console.log "Getting template #{templateName}"
    throw new Error("Unable to find template name #{templateName} in templates.") \
      if not templateName of @templates

    templates[templateName]

class CompiledClientTemplateAdapter extends CompiledTemplateAdapter
  getLayout: ->
    throw new Error('getLayout is only available on the server.')

class CompiledServerTemplateAdapter extends CompiledTemplateAdapter
  getLayout: (layoutName, notUsed, finished) ->
    try
      template = @getTemplate(layoutName)
      finished null, template
    catch error
      finished error


module.exports = (options) ->
  options ?= Object.new
  options.basePath ?= ''
  options.templateDirectory ?= path.join 'app', 'templates'
  options.commonTemplates ?= 'common'
  options.serverTemplates ?= 'server'
  options.templates ?= Object.new
  options.isServer = not window?

  loadTemplatesFrom = (moduleName) ->
    modulePath = path.join options.basePath, options.templateDirectory, moduleName
    theseTemplates = require modulePath
    options.templates[templateName] = theseTemplates[templateName] for templateName of theseTemplates

  loadTemplatesFrom(options.commonTemplates) if options.commonTemplates
  loadTemplatesFrom(options.serverTemplates) if options.serverTemplates

  if options.isServer then new CompiledServerTemplateAdapter else
    new CompiledClientTemplateAdapter

