describe 'rendr-dot template adapter', ->
  describe 'getTemplate', ->
    it 'returns a function', ->
      rendrDot = require('../src/index')()
      getTemplateResult = rendrDot.getTemplate()
      expect(typeof getTemplateResult).toBe('function')

  describe 'getLayout', ->
    it 'is a function', ->
      rendrDot = require('../src/index')()
      expect(typeof rendrDot.getLayout).toBe('function')

    describe 'when complete', ->
      it 'invokes a callback with a function', ->
        rendrDot = require('../src/index')()
        callback = jasmine.createSpy 'getLayout callback'

        rendrDot.getLayout(null, null, callback)
        expect(typeof callback.calls.mostRecent().args[1]).toBe('function')


