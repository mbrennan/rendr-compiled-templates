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

module.exports = (isServer = not window?) ->
  if isServer then new CompiledServerTemplateAdapter else new CompiledClientTemplateAdapter
