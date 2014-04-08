module.exports = (grunt) ->
  grunt.initConfig(
    coffee:
      compile_src:
        expand:   true,
        cwd:      'src',
        src:      ['**/*.coffee'],
        dest:     './'
        ext:      '.js'
        extDot:   'last'
  )

  grunt.loadNpmTasks 'grunt-contrib-coffee'