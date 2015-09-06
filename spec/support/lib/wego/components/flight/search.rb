module WegoTestSupport
  module Flight
    module Search
      def self.stub_search_request_response
        response = {}
        yield response
        if response[:success] == 1
          response_body = {
              :airlines => response[:airlines]
          }.to_xml(:root => 'root')
        else
          response_body = Wego::XmlUtils.get_one_tag_xml('error', response[:error_message])
        end

        search = Wego::Flight::Search.instance
        connection = Faraday.new do |builder|
          builder.adapter :test do |stubs|
            stubs.post(Wego::Flight::Info.flight_server_search_path) { [200, {}, response_body] }
          end
        end
        search.stub_flight_server_connection(connection)
      end
    end
  end
end