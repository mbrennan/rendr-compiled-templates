path = require 'path'


class CompiledTemplateAdapter
  constructor: (@templates) ->

  getTemplate: (templateName) ->
    throw new Error("Unable to get template; no template name was supplied") if not templateName

    if not @templates[templateName]?
      throw new Error("Unable to find template name #{templateName} in templates.")

    @templates[templateName]

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
  options.commonModule ?= 'common'
  options.serverModule ?= 'server'
  options.templates ?= new Object
  options.isServer = not window?

  loadTemplatesFrom = (moduleName) ->
    modulePath = path.join options.basePath, options.templateDirectory, moduleName
    theseTemplates = require modulePath
    options.templates[templateName] = theseTemplates[templateName] for templateName of theseTemplates

  loadTemplatesFrom(options.commonModule) if options.commonModule
  loadTemplatesFrom(options.serverModule) if options.serverModule

  adapter = if options.isServer then CompiledServerTemplateAdapter else CompiledClientTemplateAdapter
  new adapter(options.templates)

