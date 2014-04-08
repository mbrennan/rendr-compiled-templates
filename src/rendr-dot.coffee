module.exports = (options) ->
  path = require('path')
  fileSystem = require('fs')

  getTemplate: ->
    ->
  getLayout: (filename, directory, finished) ->
    throw new Error('getLayout is only available on the server.') if not options.isServer()

    layoutFilePath = path.join(directory, filename)

    console.log("about to call fs.exists (#{layoutFilePath})...")
    fileSystem.exists layoutFilePath, (exists) ->
      console.log('inside fs.exists, calling callback...')
      finished("Unable to load layout, '#{layoutFilePath}' does not exist.") if not exists

      z = ->

      finished(null, z)
