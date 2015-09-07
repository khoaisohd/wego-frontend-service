module WegoTestSupport
  module Random
    def self.get_random_string_array
      times = 10
      arr = []
      times.times do
        arr += [get_random_string]
      end
      arr
    end

    def self.get_random_string
      (0...8).map { (65 + rand(26)).chr }.join
    end
  end
end