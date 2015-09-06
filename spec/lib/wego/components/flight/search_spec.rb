require 'spec_helper'

describe Wego::Flight::Search do

  flight_search_test_support = WegoTestSupport::Flight::Search
  random = WegoTestSupport::Random
  flight_search = Wego::Flight::Search.instance

  before do
    if success == 1
      flight_search_test_support.stub_search_request_response do |response|
        response[:success] = 1
        response[:airlines] = airlines
      end
    else
      flight_search_test_support.stub_search_request_response do |response|
        response[:success] = 0
        response[:error_message] = error_message
      end
    end

  end

  subject(:results) do
    flight_search.search_flight do |query|
      query[:from] = random.get_random_string
      query[:to] = random.get_random_string
    end
  end

  context "When the search finds results" do
    let(:success) { 1 }
    let(:airlines) { random.get_random_string_array }

    it 'request should be successful' do
      expect(results[:success]).to eq(1)
    end

    it 'request should return correct airlines' do
      expect(results[:airlines]).to match_array(airlines)
    end

  end

  context "When the search doesn't find results" do
    let(:success) { 0 }
    let(:error_message) { random.get_random_string }

    it 'request should be failed' do
      expect(results[:success]).to eq(0)
    end

    it 'request should return correct error message' do
      expect(results[:error_message]).to eq(error_message)
    end
  end
end
