should  = require 'should'

describe 'rendr-compiled-templates template adapter', ->
  beforeEach ->
    @templateAdapter = require('./test-template-adapter.coffee')()
    @identityValue = 'a template'
    @identity = identity: @identityValue

  describe 'method getLayout', ->
    describe 'when passed a template name', ->
      it 'should return a compiled template', (done) ->
        @templateAdapter.getLayout 'identity', null, (error, template) =>
          should.not.exist error
          template(@identity).should.be.exactly @identityValue
          done()

