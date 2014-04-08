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
          this.callback = jasmine.createSpy 'getLayout callback'
          this.callback.and.callFake ->
            done()

          this.templateAdapter.getLayout('__layout', 'app/templates', this.callback)
          context = this

          setTimeout 0, ->
            console.log('in setTimeout 1')
            mostRecentCall = context.callback.calls.mostRecent()
            console.log('checking args[0]')
            firstArgument = mostRecentCall.args[0]
            secondArgument = mostRecentCall.args[1]

            expect(firstArgument).toBeNull()
            expect(secondArgument).toBe('function')

      describe 'when completed with an error', ->
        it 'invokes a callback with an error', (done) ->
          this.callback = jasmine.createSpy 'getLayout callback'
          this.callback.and.callFake ->
            done()

          this.templateAdapter.getLayout(
            'a_bad_file_name.bad',
            'a/bad/path',
            this.callback)

          context = this

          setTimeout 0, ->
            console.log('in setTimeout 2')
            mostRecentCall = context.callback.calls.mostRecent()
            firstArgument = mostRecentCall.args[0]
            secondArgument = mostRecentCall.args[1]

            expect(firstArgument).not.toBeNull()
            expect(secondArgument).toBeNull()

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
