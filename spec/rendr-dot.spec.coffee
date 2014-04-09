describe 'rendr-dot template adapter', ->
  beforeEach ->
    this.rendrDot = require('./config').rendrDot()
    this.identityValue = 'layout template'
    this.identity = identity: this.identityValue

  describe 'function getLayout', ->
    describe 'when passed a pre-compiled template name', ->
      it 'should return a compiled doT template', (done) ->
        context = this
        this.rendrDot.getLayout 'preCompiledIdentity', null, (error, template) ->
          expect(error).toBeFalsy()
          expect(template(context.identity)).toBe(context.identityValue)
          done()

    describe 'when passed a runtime identity template name', ->
      it 'should return a compiled template using the base directory', (done) ->
        context = this
        this.rendrDot.getLayout 'runtimeIdentity', 'spec/runtime', (error, template) ->
          expect(error).toBeFalsy()
          expect(template(context.identity)).toBe(context.identityValue)
          done()

