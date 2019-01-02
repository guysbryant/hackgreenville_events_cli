class HackgreenvilleEventsCli::Scraper
    attr_accessor :doc
    def initialize(url)
        @doc = Nokogiri::HTML(open(url))
    end

    def scrape_events(how_many = 5)
        events = @doc.search("div.container li")
        events[0..how_many -1].map do |event|
                new_event = {
                    :name => event.search("strong")[0].text, 
                    :time => event.search("p")[0].children[0].text.strip.gsub("Time: ", ""),
                    :rsvp_url => event.search("p a")[0].attributes['href'].value,
                }
                HackgreenvilleEventsCli::Events.new(new_event)
        end
    end
    def scrape_more_info
        event_info = {
            :description => @doc.search("div.event-description p").text,
            :attendees => @doc.search("h3.attendees-sample-total span").text.gsub("Attendees (", "").gsub(")", ""),
            :hosted_by => @doc.search("div.event-info-hosts-text span.text--secondary span.link").text,
            :how_often => @doc.search("div.eventTimeDisplay p")[0].text,
            :location => @doc.search("p.venueDisplay-venue-address").text,
            :how_to_find_us => @doc.search("div.venueDisplay-venue-howToFindUs p.text--caption").text
            }            
    end
end