describe 'rendr-dot template adapter', ->
  describe 'function getLayout', ->
    describe 'when passed a valid template name in the first parameter', ->
      it 'should return a compiled doT template', (done) ->
        rendrDot = require('./config').rendrDot()
        rendrDot.getLayout 'identity', null, (error, template) ->
          expect(error).toBeFalsy()
          expect(template(identity: 'layout template')).toBe('layout template')
          done()

