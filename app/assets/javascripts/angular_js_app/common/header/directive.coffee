Wego = angular.module('wego')
Wego.directive('wegoHeader', ->
  retrict: 'E'
  replace: false
  templateUrl: 'common/header/view.html',
  link: (scope, element, attrs)->
)