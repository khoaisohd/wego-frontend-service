require 'faraday'
module Wego
  module Flight
    class Search
      include Singleton

      # Public: Search the flight
      #
      # query
      #     from              string
      #     to                string
      #
      # return
      #     success           int, value 0 | 1
      #     airlines          string[]
      #     error_message     string
      #
      def search_flight
        query = {}
        yield query
        if self.validate_query? query
          request_body = {
              :from => query[:from],
              :to => query[:to]
          }

          response = flight_server_connection.post do |req|
            req.url(Wego::Flight::Info.flight_server_search_path)
            req.headers['Content-Type'] = 'application/xml'
            req.body = request_body.to_xml(:root => 'root')
          end
          response_body = Hash.from_xml(response.body)

          if response_body.has_key?('error')
            {
                :success => 0,
                :error_message => response_body['error']
            }
          else
            root = response_body['root']
            if root
              {
                  :success => 1,
                  :airlines => root['airlines']
              }
            end
          end
        end
      end

      def validate_query?(query)
        query.has_key?(:from) && query.has_key?(:to)
      end

      def flight_server_connection
        if Wego::System.run_in_test? && @use_stub
          @stub_flight_server_connection
        else
          Faraday.new(:url => Flight::Info.flight_server_url) do |faraday|
            faraday.request  :url_encoded
            faraday.response :logger
            faraday.adapter  Faraday.default_adapter
          end
        end
      end

      # This Function is only used for testing to stub the search request result
      def stub_flight_server_connection(connection)
        if Wego::System.run_in_test?
          @stub_flight_server_connection = connection
          @use_stub =  true
        end
      end

    end
  end
end
