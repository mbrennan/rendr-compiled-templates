should  = require 'should'
sinon   = require 'sinon'

describe 'rendr-dot template adapter', ->
  beforeEach ->
    dot = require('dot')
    @dotProcess = sinon.spy(dot, 'process')
    @rendrDot = require('./config').rendrDot(dot: dot)
    @identityValue = 'layout template'
    @identity = identity: @identityValue

  afterEach ->
    @dotProcess.restore()

  it 'should only pre-compile templates once', ->
    @dotProcess.callCount.should.be.exactly(1)

  describe 'method getLayout', ->
    describe 'when passed a pre-compiled template name', ->
      it 'should return a compiled doT template', (done) ->
        @rendrDot.getLayout 'preCompiledIdentity', null, (error, template) =>
          should.not.exist error
          template(@identity).should.be.exactly @identityValue
          done()

    describe 'when passed a runtime identity template name', ->
      it 'should return a compiled template using the base directory', (done) ->
        path = require 'path'
        basePath = path.join __dirname, 'runtime'
        @rendrDot.getLayout 'runtimeIdentity', basePath, (error, template) =>
          should.not.exist error
          template(@identity).should.be.exactly @identityValue
          done()

      it 'should add the runtime identity to the list of pre-compiled templates', (done) ->
        path = require 'path'
        basePath = path.join __dirname, 'runtime'
        @rendrDot.getLayout 'runtimeIdentity', basePath, (error, firstTemplate) =>
          should.not.exist error
          firstTemplate.should.exist

          @rendrDot.getLayout 'runtimeIdentity', null, (error, secondTemplate) =>
            should.not.exist error
            firstTemplate(@identity).should.be.exactly(secondTemplate(@identity))
            done()

