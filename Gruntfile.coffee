#
# Author: Scott Rogers
# -------------------------------------------------------------
# Base Gruntfile
# -------------------------------------------------------------
#
# Shouldn't need any setup process.cwd() should get cwd.
# Create source files in respective places...
# CoffeeScript goes in public/coffee
# Grunt does some shit and outputs -> public/js/twitfav.min.js
# LESS goes in goes public/less and outputs -> public/css
# if there are any issues with compiling comment out uglify
# and change the concat to the uglify build path
#
# tasks: default
#        puts grunt in dev mode to watch to changes
#
#        build
#        mainly for production. but when you just need assets
#        rebuilt and dont watch to use watch.
#
# This can actually be used for any other projects too w/o much fuss

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee:
      glob_to_multiple:
        options:
          bare: true #prevents the need to namespace everything :)
        expand: true
        flatten: true
        cwd: process.cwd()
        src: ['src/coffee/**/*.coffee', 'src/coffee/*.coffee']
        dest: 'src/js/build'
        ext: '.js'
    concat:
      options:
        separator: ';'
      build:
        src: ['src/js/lib/*.js', 'src/js/build/*.js']
        dest: 'src/js/<%= pkg.name %>.min.js'
      dev:
        src: ['src/js/lib/*.js', 'src/js/build/*.js']
        dest: 'public/js/<%= pkg.name %>.min.js'
    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      build:
        files: 'public/js/<%= pkg.name %>.min.js' : ['src/js/<%= pkg.name %>.min.js']
    less:
      build:
        files:
          "public/css/<%= pkg.name %>.css": ["src/less/<%= pkg.name %>.less"]
    watch:
      files: ['<%= coffee.glob_to_multiple.src %>', 'src/less/*.less']
      tasks: ['coffee', 'concat:dev', 'less']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['coffee', 'concat:dev', 'less', 'watch']
  grunt.registerTask 'build', ['coffee', 'concat:build', 'uglify', 'less']
