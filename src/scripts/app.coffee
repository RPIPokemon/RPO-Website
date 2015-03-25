require 'angular'
require 'angular-ui-router'

angular.module 'RPO', ['ui.router']

.config ($stateProvider, $urlRouterProvider) ->
    $stateProvider.state 'home',
        url: '/home'
        template: '<i class="fa fa-mars-stroke"></i>'
        
    $urlRouterProvider.otherwise 'home'