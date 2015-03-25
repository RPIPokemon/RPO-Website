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
                    'include css': yes
                    
        jade:
            dist:
                files:
                    'target/index.html': 'src/templates/app.jade'
                    
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
            dist: ['target/*.*']
            
        connect:
            server:
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