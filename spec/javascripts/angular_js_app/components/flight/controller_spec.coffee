
describe "WegoFlightSearchController", ->
  scope        = null
  ctrl         = null
  resource     = null
  httpBackend  = null
  flash        = null

  setupController =(results)->
    inject(($rootScope, $resource, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      resource    = $resource
      httpBackend = $httpBackend
      flash = _flash_

      httpBackend.expectPOST('/flights/search').respond(results)

      ctrl = $controller('WegoFlightSearchController', $scope: scope)
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
      beforeEach ->
        setupController(results)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.airlines).toEqualData(results.airlines)

    describe "search doesn't have results", ->
      results =
        success: 0
        error_message: "No airline operating between desired locations"
      beforeEach ->
        setupController(results)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.airlines).toEqualData([])
        expect(flash.error).toBe(results.error_message)





