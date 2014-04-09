module.exports = (options) ->
  path = require('path')
  fileSystem = require('fs')

  getTemplate: ->
    ->
  getLayout: (filename, baseDirectory, finished) ->
    throw new Error('getLayout is only available on the server.') if not options.isServer

    layoutFilePath = path.join(baseDirectory, options.layoutPath, filename + options.fileExtension)

    fileSystem.exists layoutFilePath, (exists) ->
      finished("Unable to load layout, '#{layoutFilePath}' does not exist.") if not exists

      z = ->

      finished(null, z)
