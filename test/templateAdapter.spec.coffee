should = require 'should'

describe 'rendr template adapter', ->
  beforeEach ->
    this.templateAdapter = require('./config').templateAdapter()

  describe 'interface', ->
    describe 'method getTemplate', ->
      it 'returns a function', ->
        template = this.templateAdapter.getTemplate()
        template.should.be.a.Function

    describe 'method getLayout', ->
      describe 'when supplied with valid parameters', ->
        it 'invokes a callback with a function', (done) ->
          path = require 'path'
          basePath = path.join('spec', 'templateAdapter')
          this.templateAdapter.getLayout(
            'preCompiledIdentity',
            basePath,
            (error, template) ->
              should.not.exist error
              template.should.be.a.Function
              done()
          )

      describe 'when completed with an error', ->
        it 'invokes a callback with an error', (done) ->
          this.templateAdapter.getLayout 'a_bad_file_name.bad', 'a/bad/path', (error, template) ->
            error.should.exist
            should.not.exist template
            done()

      describe 'when running on client', ->
        it 'should error', ->
          this.templateAdapter = require('./config').templateAdapter(
            isServer: false
          )
          this.templateAdapter.getLayout.bind(null).should.throw()
