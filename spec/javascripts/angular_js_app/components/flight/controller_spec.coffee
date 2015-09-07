
describe "WegoFlightSearchController", ->
  scope        = null
  ctrl         = null
  resource     = null
  httpBackend  = null
  flash        = null

  setupController =(query, results)->
    inject(($rootScope, $resource, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      resource    = $resource
      httpBackend = $httpBackend
      flash = _flash_

      httpBackend.expectPOST('/flights/search').respond(results)

      ctrl = $controller('WegoFlightSearchController', $scope: scope)
      scope.search(query)
    )

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  beforeEach(module("wego"))

  describe 'controller search', ->
    describe 'search has results', ->
      results =
        success: 1
        airlines: ['Singapore', 'Malaysia']
      query =
        from: 'Singapore',
        end: 'Hanoi'

      beforeEach ->
        setupController(query, results)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.airlines).toEqualData(results.airlines)

    describe "search doesn't have results", ->
      results =
        success: 0
        error_message: "No airline operating between desired locations"
      query =
        from: 'Singapore',
        end: 'Hanoi'
      beforeEach ->
        setupController(query, results)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.airlines).toEqualData([])
        expect(flash.error).toBe(results.error_message)





