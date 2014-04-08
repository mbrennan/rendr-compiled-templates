describe 'rendr-dot template adapter', ->
  it 'has a getTemplate function', ->
    rendrDot = require('../index')()
    expect(typeof rendrDot.getTemplate).toBe('function')


