module Wego
  module Flight
    module Info

      def self.flight_server_url
        Wego::Settings.value('flight.flight_server.url')
      end

      def self.flight_server_search_path
        Wego::Settings.value('flight.flight_server.search_path')
      end
    end
  end
end