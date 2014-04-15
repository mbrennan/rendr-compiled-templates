path = require 'path'
should = require 'should'

describe 'rendr template adapter', ->
  beforeEach ->
    @templateAdapter = require('./test-template-adapter')()
    @templateName = 'identity'

  describe 'interface', ->
    describe 'method getTemplate', ->
      describe 'when no template name is supplied', ->
        it 'throws an exception', ->
          @templateAdapter.getTemplate.bind(null).should.throw()

      describe 'when a valid template is supplied', ->
        it 'returns a function', ->
          template = @templateAdapter.getTemplate(@templateName)
          template.should.be.a.Function


    describe 'method getLayout', ->
      describe 'when supplied with valid parameters', ->
        it 'invokes a callback with a function', (done) ->
          basePath = path.join('spec', 'templateAdapter')
          @templateAdapter.getLayout(
            'identity',
            basePath,
            (error, template) ->
              should.not.exist error
              template.should.be.a.Function
              done()
          )

      describe 'when completed with an error', ->
        it 'invokes a callback with an error', (done) ->
          @templateAdapter.getLayout 'a_bad_file_name.bad', 'a/bad/path', (error, template) ->
            error.should.exist
            should.not.exist template
            done()

      describe 'when running on client', ->
        it 'should error', ->
          @templateAdapter = require('./test-template-adapter')(isServer: false)
          @templateAdapter.getLayout.bind(null).should.throw()
