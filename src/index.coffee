module.exports = (options) ->
  path = require 'path'
  fileSystem = require 'fs'

  options ?= {}
  options.isServer ?= not window?
  options.fileExtension ?= '.dot'
  options.basePath ?= __dirname
  options.templatePath ?= path.join 'app', 'templates'

  dot = require('dot')
  templatePath = path.join options.basePath, options.templatePath
  preCompiledTemplates = dot.process path: templatePath

  getTemplate: ->
    ->
  getLayout: (template, baseDirectory, finished) ->
    throw new Error('getLayout is only available on the server.') if not options.isServer

    return finished(null, preCompiledTemplates[template]) if template of preCompiledTemplates

    layoutFilePath = path.join(baseDirectory, options.templatePath, template + options.fileExtension)

    fileSystem.exists layoutFilePath, (exists) ->
      return finished("Unable to load layout, #{layoutFilePath} does not exist.") if not exists

      fileSystem.readFile layoutFilePath, 'utf8', (error, templateSource) ->
        return finished("Unable to read file #{layoutFilePath}: #{error}") if error

        template = dot.compile(templateSource)
        finished(null, template)
