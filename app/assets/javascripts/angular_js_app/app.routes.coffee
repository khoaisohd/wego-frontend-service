
Wego = angular.module('wego')

Wego.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->
    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")
    $routeProvider
    .when('/',
      templateUrl: 'components/flight/search/view.html'
      controller: 'WegoFlightSearchController'
    )
])

controllers = angular.module('controllers',[])