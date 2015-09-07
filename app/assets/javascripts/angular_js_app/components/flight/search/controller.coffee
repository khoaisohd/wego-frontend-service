controllers = angular.module('controllers')

controllers.controller("WegoFlightSearchController", [ '$scope', '$routeParams', 'WegoFligthSearch', 'flash',
  ($scope,$routeParams, WegoFligthSearch, flash)->

    $scope.search = (from, to)->
      $scope.show_loading = true
      $scope.airlines = null
      flash.error = null
      WegoFligthSearch(from, to)
        .then (airlines)->
          $scope.airlines = airlines
        , (error_message)->
          flash.error = error_message
        .finally ->
          $scope.show_loading = false
])