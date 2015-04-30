js_dependencies = [
    './bower_components/angular/angular.js:angular'
    './bower_components/angular-bootstrap/ui-bootstrap-tpls.js:angular-bootstrap'
    './bower_components/angular-parallax/scripts/angular-parallax.js:angular-parallax'
    './bower_components/angular-ui-router/release/angular-ui-router.js:angular-ui-router'
]

css_depenencies = [
    './src/styles/bootstrap.styl'
    './src/styles/raleway.styl'
]

module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        src_dir: 'src'
        target_dir: 'target/public_html'
        resrc_dir: 'resources'
        img_dir: 'img'
        gitinfo: {}

        browserify:
            dist:
                files:
                    '<%= target_dir %>/app.js': ['<%= src_dir %>/scripts/app.coffee']
                options:
                    transform: ['coffeeify', 'debowerify', ['browserify-plain-jade',
                        build: '<%= gitinfo.local.branch.current.shortSHA %>'
                        version: '<%= pkg.version %>'
                        __debug: no
                    ]]
                    browserifyOptions:
                        extensions: ['.coffee']

            debug:
                files:
                    '<%= target_dir %>/app.js': ['<%= src_dir %>/scripts/app.coffee']
                options:
                    transform: ['coffeeify', ['browserify-plain-jade',
                        build: '<%= gitinfo.local.branch.current.shortSHA %>'
                        version: '<%= pkg.version %>'
                        __debug: no
                    ]]
                    external: js_dependencies
                    browserifyOptions:
                        extensions: ['.coffee']
                        debug: yes

            libs:
                dest: '<%= target_dir %>/libs.js'
                src: []
                options:
                    require: js_dependencies
                    browserifyOptions:
                        debug: yes

        coffeelint:
            dist: ['<%= src_dir %>/scripts/**/*.coffee']
            options:
                max_line_length:
                    level: 'ignore'
                indentation:
                    level: 'ignore'

        stylus:
            dist:
                files:
                    '<%= target_dir %>/app.css': '<%= src_dir %>/styles/app.styl'
                options:
                    define:
                        debug: no
                    paths: ['bower_components', 'node_modules', '<%= src_dir %>/styles']
                    'include css': yes

            debug:
                files:
                    '<%= target_dir %>/app.css': '<%= src_dir %>/styles/app.styl'
                options:
                    define:
                        debug: yes
                    paths: ['bower_components', 'node_modules', '<%= src_dir %>/styles']
                    compress: no
                    'include css': yes
                    sourcemap:
                        inline: yes

            libs:
                dest: '<%= target_dir %>/libs.css'
                src: css_depenencies
                options:
                    paths: ['bower_components', 'node_modules', '<%= src_dir %>/styles']
                    compress: no
                    'include css': yes
                    sourcemap:
                        inline: yes

        jade:
            dist:
                files:
                    '<%= target_dir %>/index.html': '<%= src_dir %>/templates/app.jade'
                options:
                    data:
                        debug: no
                        version: '<%= pkg.version %>'
                        build: '<%= gitinfo.local.branch.current.shortSHA %>'

            debug:
                files:
                    '<%= target_dir %>/index.html': '<%= src_dir %>/templates/app.jade'
                options:
                    data:
                        debug: yes
                        version: '<%= pkg.version %>'
                        build: '<%= gitinfo.local.branch.current.shortSHA %>'

        uglify:
            dist:
                files:
                    '<%= target_dir %>/app.js': ['<%= target_dir %>/app.js']
                options:
                    mangle: no

        cssmin:
            dist:
                files:
                    '<%= target_dir %>/app.css': ['<%= target_dir %>/app.css']
                options:
                    keepSpecialComments: 0

        copy:
            resrc:
                files: [
                    {
                        expand: yes
                        cwd: '<%= resrc_dir %>'
                        src: ['**']
                        dest: '<%= target_dir %>/'
                    }
                ]

            dist:
                files: [
                    {
                        expand: yes
                        cwd: '<%= resrc_dir %>'
                        src: ['**', '!<%= img_dir %>/**']
                        dest: '<%= target_dir %>/'
                    }
                ]


            fa:
                files: [
                    {
                        expand: yes
                        cwd: 'bower_components/font-awesome'
                        src: ['fonts/**']
                        dest: '<%= target_dir %>/'
                    }
                ]

        imagemin:
            dist:
                files: [
                    {
                        expand: yes
                        cwd: '<%= resrc_dir %>'
                        src: ['<%= img_dir %>/**/*.{png,jpg,gif}']
                        dest: '<%= target_dir %>'
                    }
                ]

        clean:
            target: ['<%= target_dir %>/*']

        connect:
            serve:
                options:
                    base: '<%= target_dir %>'
                    keepalive: yes
                    livereload: no

            debug:
                options:
                    base: '<%= target_dir %>'
                    livereload: yes

        watch:
            app:
                files: ['<%= src_dir %>/templates/app.jade']
                tasks: ['gitinfo', 'jade:debug']

            jade:
                files: ['<%= src_dir %>/templates/**/*.jade', '!<%= src_dir %>/templates/app.jade']
                tasks: ['gitinfo', 'browserify:debug']

            stylus:
                files: ['<%= src_dir %>/styles/**/*.styl']
                tasks: ['stylus:debug']

            stylus_libs:
                files: css_depenencies
                tasks: ['stylus:libs']

            coffee:
                files: ['<%= src_dir %>/scripts/**/*.coffee']
                tasks: ['browserify:debug']

            options:
                livereload: true

        'ftp-deploy':
            union:
                auth:
                    host: 'ftp.union.rpi.edu'
                    port: 21
                    authKey: 'union'

                src: 'target/public_html'
                dest: 'public_html'

    grunt.loadNpmTasks 'grunt-browserify'
    grunt.loadNpmTasks 'grunt-coffeelint'
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.loadNpmTasks 'grunt-contrib-stylus'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-imagemin'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-ftp-deploy'
    grunt.loadNpmTasks 'grunt-gitinfo'

    grunt.registerTask 'debug:prepare', ['gitinfo', 'clean', 'copy:resrc', 'copy:fa', 'browserify:libs', 'stylus:libs']
    grunt.registerTask 'debug:build', ['browserify:debug', 'jade:debug', 'stylus:debug']
    grunt.registerTask 'livereload', ['debug:prepare', 'debug:build', 'connect:debug', 'watch']

    grunt.registerTask 'build', ['gitinfo', 'coffeelint', 'clean', 'browserify:dist', 'stylus:dist', 'jade:dist']
    grunt.registerTask 'minify', ['uglify', 'cssmin', 'imagemin']
    grunt.registerTask 'default', ['build', 'minify', 'copy:dist', 'copy:fa']

    grunt.registerTask 'deploy', ['default', 'ftp-deploy:union']

    return
