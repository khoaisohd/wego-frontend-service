require 'spec_helper'

describe FlightController do
  render_views

  flight_search_test_support = WegoTestSupport::Flight::Search
  random = WegoTestSupport::Random

  describe 'search' do
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

      xhr :post, :search, { from: random.get_random_string, to: random.get_random_string }

    end

    subject(:results) { JSON.parse(response.body) }

    context "when the search finds results" do
      let(:success) { 1 }
      let(:airlines) { random.get_random_string_array }

      it 'request should return success status' do
        expect(results['success']).to eq(1)
      end

      it 'request should return correct airlines' do
        expect(results['airlines']).to match_array(airlines)
      end

    end

    context "when the search doesn't find results" do

      let(:success) { 0 }
      let(:error_message) { random.get_random_string }

      it 'request should return failed status' do
        expect(results['success']).to eq(0)
      end

      it 'request should return correct error message' do
        expect(results['error_message']).to eq(error_message)
      end
    end

  end
end