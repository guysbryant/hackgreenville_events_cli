class HackgreenvilleEventsCli::Events
    attr_accessor :name, :hosted_by, :time, :rsvp_url, :add_to_google_calendar
    @@all = []

    def initialize(hash)
        hash.each do |k, v| 
            self.send "#{k}=", v
        end
        @@all << self
    end

    def self.all
        @@all
    end
end