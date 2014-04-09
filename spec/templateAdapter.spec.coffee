describe 'rendr template adapter', ->
  beforeEach ->
    this.templateAdapter = require('./config').templateAdapter()

  describe 'interface', ->
    describe 'getTemplate', ->
      it 'returns a function', ->
        getTemplateResult = this.templateAdapter.getTemplate()
        expect(typeof getTemplateResult).toBe('function')

    describe 'method getLayout', ->
      describe 'when supplied with valid parameters', ->
        it 'invokes a callback with a function', (done) ->
          path = require 'path'
          this.templateAdapter.getLayout(
            'preCompiledIdentity',
            path.join('spec', 'templateAdapter'),
            (error, template) ->
              expect(error).toBeFalsy()
              expect(typeof template).toBe('function')
              done()
          )

      describe 'when completed with an error', ->
        it 'invokes a callback with an error', (done) ->
          this.templateAdapter.getLayout 'a_bad_file_name.bad', 'a/bad/path', (error, template) ->
            expect(error).not.toBeFalsy()
            expect(template).toBeFalsy()
            done()

      describe 'when running on client', ->
        it 'should error', ->
          this.templateAdapter = require('./config').templateAdapter(
            isServer: false
          )
          context = this
          getLayoutCall = ->
            context.templateAdapter.getLayout(null, null, context.callback)

          expect(getLayoutCall).toThrow()
