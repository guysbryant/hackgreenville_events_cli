require "nokogiri"
require "open-uri"

class HackgreenvilleEventsCli::Scraper
    # Nokogiri::HTML(open("https://hackgreenville.com/events"))
    attr_accessor :doc
    def initialize(url)
        @doc = Nokogiri::HTML(open(url))
    end

    def scrape_events
        events = @doc.search("div.container li")
        all_events = events.map do |event|
            new_event = {
                :name => @doc.search("strong")[0].text, 
                :hosted_by => @doc.search("strong")[1].text,
                :time => @doc.search("p")[0].children[0].text.strip,
                :rsvp_url => @doc.search("p a")[0].attributes['href'].value,
                :add_to_google_calendar => @doc.search("p a")[1].attributes['href'].value
            }
        end
        binding.pry
            #HackgreenvilleCli::Events.new(new_event)
            #prepare Events to recieve hash on .new
    end

    def self.scrape_more_info
    end
end