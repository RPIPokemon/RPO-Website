isMobile = require 'isMobile'

module.exports = ($scope) ->
    $scope.bannerSize = 400
    if isMobile.any
        $scope.bannerSize = 200
