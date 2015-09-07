Wego = angular.module('wego')

Wego.controller("WegoFlightSearchController", [ '$scope', '$routeParams', 'WegoFlightSearch', 'flash',
  ($scope,$routeParams, WegoFlightSearch, flash)->

    $scope.search = (from, to)->
      $scope.show_loading = true
      $scope.airlines = null
      flash.error = null
      WegoFlightSearch(from, to)
        .then (airlines)->
          $scope.airlines = airlines
        , (error_message)->
          flash.error = error_message
        .finally ->
          $scope.show_loading = false
])