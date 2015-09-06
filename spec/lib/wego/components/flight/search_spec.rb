require 'spec_helper'
require_relative '../../../../../lib/wego/wego'
require_relative '../../../../support/lib/wego/wego'

describe Wego::Flight::Search do

  flight_search_test_support = WegoTestSupport::Flight::Search
  random = WegoTestSupport::Random
  flight_search = Wego::Flight::Search.instance

  context 'Get Not Empty Flight Result' do

    airlines = random.get_random_string_array
    flight_search_test_support.stub_search_request_response do |response|
      response[:success] = 1
      response[:airlines] = airlines
    end

    result = flight_search.search_flight do |query|
      query[:from] = random.get_random_string
      query[:to] = random.get_random_string
    end

    it 'request should be successful' do
      expect(result[:success]).to eq(1)
    end

    it 'request should return correct airlines' do
      expect(result[:airlines]).to match_array(airlines)
    end

  end

  context 'Get Empty Flight Result' do

    error_message = random.get_random_string

    flight_search_test_support.stub_search_request_response do |response|
      response[:success] = 0
      response[:error_message] = error_message
    end

    result = flight_search.search_flight do |query|
      query[:from] = random.get_random_string
      query[:to] = random.get_random_string
    end

    it 'request should be failed' do
      expect(result[:success]).to eq(0)
    end

    it 'request should return correct error message' do
      expect(result[:error_message]).to eq(error_message)
    end
  end
end
