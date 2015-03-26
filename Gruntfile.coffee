module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        browserify:
            target:
                files:
                    'target/app.js': ['src/scripts/app.coffee']
                options:
                    transform: ['coffeeify', 'debowerify', 'browserify-plain-jade']
                    browserifyOptions:
                        extensions: ['.coffee']

        coffeelint:
            target: ['src/scripts/**/*.coffee']
            options:
                max_line_length:
                    level: 'ignore'
                indentation:
                    level: 'ignore'

        stylus:
            target:
                files:
                    'target/app.css': 'src/styles/app.styl'
                options:
                    paths: ['bower_components', 'node_modules', 'src/styles']
                    'include css': yes

        jade:
            target:
                files:
                    'target/index.html': 'src/templates/app.jade'

        uglify:
            target:
                files:
                    'target/app.js': ['target/app.js']
                options:
                    mangle: no

        cssmin:
            target:
                files:
                    'target/app.css': ['target/app.css']
                options:
                    keepSpecialComments: 0

        copy:
            src:
                files: [
                    {
                        expand: yes
                        cwd: 'resources'
                        src: ['**']
                        dest: 'target/'
                    }
                ]

            fa:
                files: [
                    {
                        expand: yes
                        cwd: 'bower_components/font-awesome'
                        src: ['fonts/**']
                        dest: 'target/'
                    }
                ]

        clean:
            target: ['target/*.*']

        connect:
            target:
                options:
                    base: 'target'
                    keepalive: yes


    grunt.loadNpmTasks 'grunt-browserify'
    grunt.loadNpmTasks 'grunt-coffeelint'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-connect'

    grunt.registerTask 'build', ['coffeelint', 'clean', 'browserify', 'stylus', 'jade']
    grunt.registerTask 'minify', ['uglify', 'cssmin']
    grunt.registerTask 'default', ['build', 'minify', 'copy']

    return
