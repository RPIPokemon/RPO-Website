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
        template: require '../templates/home.jade'

    $urlRouterProvider.otherwise 'home'
