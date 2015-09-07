class FlightController < ApplicationController
  def search
    flight_search = Wego::Flight::Search.instance
    result = flight_search.search_flight do |query|
      query[:from] = params['from']
      query[:to] = params['to']
    end

    if result[:success] == 1
      render :json => {
                 :success => 1,
                 :airlines => result[:airlines]
             }
    else
      render :json => {
                 :success => 0,
                 :error_message => result[:error_message]
             }
    end
  end
end