dependencies = [
    './bower_components/angular/angular.js:angular'
    './bower_components/angular-bootstrap/ui-bootstrap-tpls.js:angular-bootstrap'
    './bower_components/angular-parallax/scripts/angular-parallax.js:angular-parallax'
    './bower_components/angular-ui-router/release/angular-ui-router.js:angular-ui-router'
]

module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        browserify:
            dist:
                files:
                    'target/app.js': ['src/scripts/app.coffee']
                options:
                    transform: ['coffeeify', 'debowerify', 'browserify-plain-jade']
                    browserifyOptions:
                        extensions: ['.coffee']

            debug:
                files:
                    'target/app.js': ['src/scripts/app.coffee']
                options:
                    transform: ['coffeeify', 'browserify-plain-jade']
                    external: dependencies
                    browserifyOptions:
                        extensions: ['.coffee']

            libs:
                dest: 'target/libs.js'
                src: []
                options:
                    require: dependencies

        coffeelint:
            dist: ['src/scripts/**/*.coffee']
            options:
                max_line_length:
                    level: 'ignore'
                indentation:
                    level: 'ignore'

        stylus:
            dist:
                files:
                    'target/app.css': 'src/styles/app.styl'
                options:
                    paths: ['bower_components', 'node_modules', 'src/styles']
                    compress: no
                    'include css': yes

        jade:
            dist:
                files:
                    'target/index.html': 'src/templates/app.jade'
                options:
                    data:
                        debug: no

            debug:
                files:
                    'target/index.html': 'src/templates/app.jade'
                options:
                    data:
                        debug: yes

        uglify:
            dist:
                files:
                    'target/app.js': ['target/app.js']
                options:
                    mangle: no

        cssmin:
            dist:
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
            serve:
                options:
                    base: 'target'
                    keepalive: yes

            debug:
                options:
                    base: 'target'
                    livereload: yes

        watch:
            app:
                files: ['src/templates/app.jade']
                tasks: ['jade:debug']

            jade:
                files: ['src/templates/**/*.jade', '!src/templates/app.jade']
                tasks: ['browserify:debug']

            stylus:
                files: ['src/styles/**/*.styl']
                tasks: ['stylus']

            coffee:
                files: ['src/scripts/**/*.coffee']
                tasks: ['browserify:debug']

            options:
                livereload: true



    grunt.loadNpmTasks 'grunt-browserify'
    grunt.loadNpmTasks 'grunt-coffeelint'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    grunt.registerTask 'build', ['coffeelint', 'clean', 'browserify:dist', 'stylus', 'jade:dist']
    grunt.registerTask 'livereload', ['clean', 'copy', 'browserify:libs', 'browserify:debug', 'jade:debug', 'stylus', 'connect:debug', 'watch']
    grunt.registerTask 'minify', ['uglify', 'cssmin']
    grunt.registerTask 'default', ['build', 'minify', 'copy']

    return
