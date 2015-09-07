require 'spec_helper.rb'

feature 'Looking up flights', js: true do
  flight_search_test_support = WegoTestSupport::Flight::Search

  def search
    visit '/'
    fill_in 'from', with: 'Singapore'
    fill_in 'to', with: 'Malaysia'
    click_on "Search"
  end
  scenario 'search has results' do
    flight_search_test_support.stub_search_request_response do |response|
      response[:success] = 1
      response[:airlines] = ['Singapore Airline', 'Malaysia Airline']
    end
    search
    expect(page).to have_content('Singapore Airline')
    expect(page).to have_content('Malaysia Airline')
  end

  scenario "search doesn't have results" do
    error_message = 'No airline operating between desired locations'
    flight_search_test_support.stub_search_request_response do |response|
      response[:success] = 0
      response[:error_message] = error_message
    end
    search
    expect(page).to have_content(error_message)
  end
end