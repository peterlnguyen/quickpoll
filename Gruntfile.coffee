


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
      options:
        arrow_spacing:
          level: "error"
        missing_fat_arrows:
          level: "warn"
        max_line_length:
          level: "warn"

  grunt.registerTask "default", [ "coffeelint" ]



