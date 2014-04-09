module.exports = (options) ->
  path = require 'path'
  fileSystem = require 'fs'

  options ?= {}
  options.isServer ?= not window?
  options.fileExtension ?= '.dot'
  options.basePath ?= __dirname
  options.templatePath ?= path.join 'app', 'templates'

  dot = require('dot').process path: path.join(options.basePath, options.templatePath)

  getTemplate: ->
    ->
  getLayout: (template, baseDirectory, finished) ->
    throw new Error('getLayout is only available on the server.') if not options.isServer

    return finished(null, dot[template]) if template of dot

    layoutFilePath = path.join(baseDirectory, options.templatePath, template + options.fileExtension)

    fileSystem.exists layoutFilePath, (exists) ->
      finished("Unable to load layout, #{layoutFilePath} does not exist.") if not exists

      fileSystem.readFile layoutFilePath, 'utf8', (error, templateSource) ->
        console.log('read file complete')
        finished("Unable to read file #{layoutFilePath}: #{error}") if error

        console.log('compiling template')
        template = dot.template(templateSource)
        console.log('about to call callback')
        finished(null, template)
