should = require 'should'

describe 'rendr-dot template adapter', ->
  beforeEach ->
    this.rendrDot = require('./config').rendrDot()
    this.identityValue = 'layout template'
    this.identity = identity: this.identityValue

  describe 'method getLayout', ->
    describe 'when passed a pre-compiled template name', ->
      it 'should return a compiled doT template', (done) ->
        context = this
        this.rendrDot.getLayout 'preCompiledIdentity', null, (error, template) ->
          should.not.exist error
          template(context.identity).should.be.exactly context.identityValue
          done()

    describe 'when passed a runtime identity template name', ->
      it 'should return a compiled template using the base directory', (done) ->
        context = this
        path = require 'path'
        basePath = path.join __dirname, 'runtime'
        this.rendrDot.getLayout 'runtimeIdentity', basePath, (error, template) ->
          should.not.exist error
          template(context.identity).should.be.exactly context.identityValue
          done()

      it 'should add the runtime identity to the list of pre-compiled templates', (done) ->
        context = this
        path = require 'path'
        basePath = path.join __dirname, 'runtime'
        this.rendrDot.getLayout 'runtimeIdentity', basePath, (error, firstTemplate) ->
          should.not.exist error
          firstTemplate.should.exist

          context.rendrDot.getLayout 'runtimeIdentity', null, (error, secondTemplate) ->
            should.not.exist error
            firstTemplate(context.identity).should.be.exactly(secondTemplate(context.identity))
            done()

