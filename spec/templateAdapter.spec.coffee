describe 'rendr template adapter', ->
  beforeEach (done) ->
    this.templateAdapter = require('../src/index')()
    done()

  describe 'interface', ->
    describe 'getTemplate', ->
      it 'returns a function', ->
        getTemplateResult = this.templateAdapter.getTemplate()
        expect(typeof getTemplateResult).toBe('function')

    describe 'method getLayout', ->
      describe 'when supplied with valid parameters', ->
        it 'invokes a callback with a function', (done) ->
          # As of rendr 0.5.0, the layout file name must be '__layout'
          # and the path to the file must be 'app/templates'
          this.templateAdapter.getLayout '__layout', 'app/templates', (error, template) ->
            expect(error).toBeNull()
            expect(template).toBe('function')
            done()

      describe 'when completed with an error', ->
        it 'invokes a callback with an error', (done) ->
          this.templateAdapter.getLayout 'a_bad_file_name.bad', 'a/bad/path', (error, template) ->
            expect(error).not.toBeNull()
            expect(template).toBeNull()
            done()

      describe 'when running on client', ->
        it 'should error', ->
          this.templateAdapter = require('../src/index')(
            isServer: ->
              false
          )
          context = this
          getLayoutCall = ->
            context.templateAdapter.getLayout(null, null, context.callback)

          expect(getLayoutCall).toThrow()
