


module.exports = (grunt) ->

  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-coffeelint"

  grunt.initConfig

    pkg: grunt.file.readJSON "package.json"

    coffee:
      files:
        "app.js"

    concat:
      options:
        separator: ';'

    uglify:
      my_target:
        options:
          "something"

    coffeelint:
      app: [
        "*.coffee",
        "controllers/*.coffee", "models/*.coffee", "views/*.coffee",
        "routes/*.coffee",
      ]
      tests:
        files:
          src: [
          ]
        options:
          arrow_spacing: true
          colon_assignment_spacing: 0
          missing_fat_arrows: "warn",
          max_line_length: 300

  grunt.registerTask "default", [ "coffeelint", "concat", "uglify" ]



