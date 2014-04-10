module.exports = (options) ->
  path = require 'path'
  fileSystem = require 'fs'

  options ?= {}
  options.isServer ?= not window?
  options.fileExtension ?= '.dot'
  options.basePath ?= process.cwd()
  options.templatePath ?= path.join 'app', 'templates'

  dot = require('dot')
  templatePath = path.join options.basePath, options.templatePath
  preCompiledTemplates = dot.process path: templatePath

  getTemplate: (name) ->
    ->
  getLayout: (templateName, baseDirectory, finished) ->
    throw new Error('getLayout is only available on the server.') if not options.isServer
    return finished(null, preCompiledTemplates[templateName]) if templateName of preCompiledTemplates

    layoutFilePath = path.join(baseDirectory, options.templatePath, templateName + options.fileExtension)

    fileSystem.exists layoutFilePath, (exists) ->
      return finished("Unable to load layout, #{layoutFilePath} does not exist.") if not exists

      fileSystem.readFile layoutFilePath, 'utf8', (error, templateSource) ->
        return finished("Unable to read file #{layoutFilePath}: #{error}") if error

        template = dot.compile(templateSource)
        preCompiledTemplates[templateName] = template
        finished(null, template)
