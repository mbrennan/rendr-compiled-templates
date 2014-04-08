describe 'rendr-dot template adapter', ->
  it 'has a getTemplate function', ->
    rendrDot = require('../index')()
    expect(typeof rendrDot.getTemplate).toBe('function')

  it 'returns a function', ->
    rendrDot = require('../index')()
    getTemplateResult = rendrDot.getTemplate()
    expect(typeof getTemplateResult).toBe('function')


