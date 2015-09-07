Wego = angular.module('wego')
Wego.directive('wegoAirlineListViewItem', ->
  retrict: 'E'
  replace: false
  templateUrl: 'components/flight/airline/list_view_item/view.html',
  scope: data: '=airline'
  link: (scope, element, attrs)->
    scope.$watch('airline', (airline)->
      scope.airline = airline
    )
)