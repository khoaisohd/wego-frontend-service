module Wego
  module System
    def self.run_in_test?
      ENV["RAILS_ENV"] == 'test'
    end
  end
end