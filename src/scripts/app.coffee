require 'angular'
require 'angular-ui-router'
require 'angular-bootstrap'
require 'angular-parallax'

require './controllers'
require './services'

angular.module 'RPO', ['RPO.controllers'
                       'RPO.services'
                       'ui.router'
                       'ui.bootstrap'
                       'angular-parallax']

.config ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state 'home',
        url: '/home'
        template: require '../templates/home/layout.jade'
        abstract: yes

    .state 'home.index',
        url: ''
        views:
            content:
                template: require '../templates/home/home.jade'

    .state 'home.blog',
        url: '/blog'
        views:
            content:
                template: '<p>Future Blog!</p>'

    $urlRouterProvider.otherwise 'home'
