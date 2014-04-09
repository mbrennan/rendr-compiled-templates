module.exports = (options) ->
  path = require 'path'

  options ?= {}
  options.isServer ?= not window?
  options.layoutPath ?= path.join('app', 'templates')
  options.fileExtension ?= '.dot'

  require('./rendr-dot')(options)
