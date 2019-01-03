class HackgreenvilleEventsCli::Events
    attr_accessor :name, :hosted_by, :time, :rsvp_url, :description, :attendees, :hosted_by, :how_often, :location, :how_to_find_us, :click_here_to_rsvp

    @@all = []

    def initialize(hash)
        @name = hash[name]
        hash.each do |k, v| 
            self.public_send "#{k}=", v
        end
        @@all << self
    end

    def self.all
        @@all
    end

    def add_info(hash)
        hash.each do |k, v|
            self.public_send "#{k}=", v
        end
    end
end