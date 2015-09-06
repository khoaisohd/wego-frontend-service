require 'spec_helper'

describe FlightController do
  render_views
  flight_search_test_support = WegoTestSupport::Flight::Search
  random = WegoTestSupport::Random

  describe 'search' do
    before do
      xhr :post, :search, { from: random.get_random_string, to: random.get_random_string }
    end

    subject(:results) { JSON.parse(response.body) }

    context "when the search finds results" do
      airlines = random.get_random_string_array
      flight_search_test_support.stub_search_request_response do |response|
        response[:success] = 1
        response[:airlines] = airlines
      end
      it 'request should return success status' do
        expect(result['success']).to eq(1)
      end
      it 'request should return correct airlines' do
        expect(result['airlines']).to match_array(airlines)
      end

    end

    context "when the search doesn't find results" do

      error_message = random.get_random_string

      flight_search_test_support.stub_search_request_response do |response|
        response[:success] = 0
        response[:error_message] = error_message
      end

      it 'request should return failed status' do
        expect(result['success']).to eq(0)
      end

      it 'request should return correct error message' do
        expect(result['error_message']).to match_array(error_message)
      end
    end

  end
end