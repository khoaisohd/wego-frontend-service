Wego = angular.module('wego')
Wego.directive('wegoWidgetsLoadingIndicator', ->
  retrict: 'E'
  replace: false
  templateUrl: 'common/widgets/loading_indicator/view.html',
  link: (scope, element, attrs)->
    scope.message = attrs.message || "Loading"
)