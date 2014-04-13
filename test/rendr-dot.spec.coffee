should  = require 'should'

describe 'rendr-dot template adapter', ->
  beforeEach ->
    dot = require('dot')
    @rendrDot = require('./test-rendr-dot')()
    @identityValue = 'a template'
    @identity = identity: @identityValue

  afterEach ->
    @dotCompile.restore()

  describe 'method getLayout', ->
    describe 'when passed a template name', ->
      it 'should return a compiled doT template', (done) ->
        @rendrDot.getLayout 'preCompiledIdentity', null, (error, template) =>
          should.not.exist error
          template(@identity).should.be.exactly @identityValue
          done()

