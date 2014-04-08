module.exports = (options) ->
  options ?= {}
  options.isServer ?= ->
    not window?

  require('./rendr-dot')(options)
