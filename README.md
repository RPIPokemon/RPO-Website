# RPO-Website
Website for Rensselaer Pokemon Organization

# Development

## Setting up your environment
To set up the development environment you need a few things. The most important
of which is node.js. Seeing as how you want to develop this, I'll leave it to
you to download and install it for your platform. Once you have node installed,
you should also have npm. We are going to use npm to install a variety of
things.

Start by installing bower with

    [sudo] npm install -g bower

Bower is a front end package manager that lets us install other things like
angular. After bower, let's install grunt-cli with

    [sudo] npm install -g grunt-cli

Grunt is a task runner, and a great one at that. grunt-cli is for interfacing
with grunt-based projects. Once that's done, dependencies need to be installed.
Do that with

    npm install
    bower install

and then the dependencies to build the project will be installed, as will the
front-end stuff. Once all that is done, we can run a live version of the site.
Do that by running

    grunt livereload

That task sets up grunt to recompile and reload any files you change, and make
the changes in the browser. Check it out by going to localhost:8000.

To make a production-ready build, simply run

    grunt

and deploy the files found in the `target` directory.

## File Structure

The file structure is pretty simple. All of the static resources (images, fonts)
go into the `resources` directory.

The `src/styles` directory holds all of the
stylus files that get compiled into CSS. `src/scripts` holds the things that run
the site, namely `src/scripts/services` is for angular services and
`src/scripts/controllers` is for angular controllers. `src/scripts/app.coffee`
routes everything, and should require the rest of the files.

`src/templates` contains the templates for the site, which can be required in
`app.coffee` `src/templates/app.jade` is the main file, which should not be
edited.
