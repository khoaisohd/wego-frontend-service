Wego = angular.module('wego')

Wego.factory('WegoFligthSearch', ($http, $q)->
  (from, to)->
    deferred = $q.defer()
    $http.post('/flight/search', from: from, to: to)
    .then (response)->
      data = response.data || {}
      if data.success == 1
        deferred.resolve(data.airlines)
      else
        deferred.reject(data.error_message)
    , (response)->
      deferred.reject()
    deferred.promise
)