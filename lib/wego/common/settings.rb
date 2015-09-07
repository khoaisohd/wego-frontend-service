module Wego
  module Settings

    @schema = {
      :flight => {
          :flight_server => {
              :url => 'https://glacial-shelf-4962.herokuapp.com',
              :search_path => '/flights/search'
          }
      },
      :front_end => {
          :ui_framework => 'angular_js'
      }
    }

    def self.value(setting)
      setting_valid = self.is_setting_valid setting
      if setting_valid
        value = self.value_from_database setting
        if value == nil
          value = self.default_value setting
        end
        value
      else
        raise 'Setting is not in schema'
      end
    end

    def self.default_value(setting)
      tokens = setting.split('.')
      data = @schema
      tokens.each do |element|
        data = data[element.to_sym]
      end
      data
    end

    def self.is_setting_valid(setting)
      tokens = setting.split('.')
      schema = @schema
      setting_valid = true
      tokens.each do |element|

        if schema.has_key?(element.to_sym)
          schema = schema[element.to_sym]
        else
          setting_valid = false
          break
        end
      end
      setting_valid
    end

    def self.value_from_database(setting)
      #@TODO
    end
  end
end