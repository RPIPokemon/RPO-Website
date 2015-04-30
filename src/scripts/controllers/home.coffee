angular = require 'angular'
isMobile = require 'isMobile'

module.exports = ($scope) ->
    $scope.bannerSize = 400
    if isMobile.any
        $scope.bannerSize = 200
        angular.element('#home-wallpaper').removeAttr 'parallax-background'
        angular.element('#home-content').removeAttr 'parallax-background'
