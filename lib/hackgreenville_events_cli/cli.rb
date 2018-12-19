require "open-uri"
require "nokogiri"
class HackgreenvilleEventsCli::CLI
    attr_accessor :name, :time, :location, :url

    @@all = [] #remvoe because the Events class will handle
    def start
       puts "Welcome to the HackGreenville Events Gem \n"
       binding.pry
       #events = scrape events
        events.each {|event| @@all << event}
       self.list_events 
       self.menu
    end

    def self.all #remvoe because the Events class will handle
        @@all
    end

    def self.list_events 
        puts "Here are the upcoming events in Greenville, SC: \n"
        #events = HackgreenvilleEventsCli::Scraper
        all.each_with_index(1) do |event, index| #will be changed to Events.all.each
            puts "#{index}. #{event.name}: #{event.time} #{event.rsvp} #{event.add_to_google_calendar}"
        end
    end

    def self.menu
        puts "Select an event by typing the associated number to get more information about that event or type exit to quit: \n"
        input = gets.strip
        if input.class == String
            if input.downcase == "exit"
                self.quit 
            end
        end

        index = input.to_i - 1
        
        if index >= 0 && index < @@all.size
            more_info = Scraper.new(@@all[index].url)
            puts "#{more_info.whatever}"

            #scrape meetup for more info
            #scrape (@@all[input - 1].url) Change to Events.all[input - 1]
        else 
            puts "I don't understand. \n"
            self.menu
        end
        
    end

    def self.quit 
        #how to quit program?
    end
end