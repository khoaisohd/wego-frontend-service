controllers = angular.module('controllers')

controllers.controller("WegoFlightSearchController", [ '$scope', '$routeParams', 'WegoFligthSearch', 'flash',
  ($scope,$routeParams, WegoFligthSearch, flash)->

    $scope.search = (from, to)->
      WegoFligthSearch(from, to)
        .then (airlines)->
          $scope.airlines = airlines
        , (error_message)->
          $scope.airlines = null
          flash.error = error_message

])