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
        events.map do |event|
            if HackgreenvilleEventsCli::Events.all.size < 5
                new_event = {
                    :name => event.search("strong")[0].text, 
                    # :hosted_by => event.search("strong")[1].text,
                    :time => event.search("p")[0].children[0].text.strip,
                    :rsvp_url => event.search("p a")[0].attributes['href'].value,
                    :add_to_google_calendar => event.search("p a")[1].attributes['href'].value
                }
                HackgreenvilleEventsCli::Events.new(new_event)
            end
        end
    end

    def scrape_more_info
        event_info = {
            :description => @doc.search("div.event-description p").text,
            :attendees => @doc.search("h3.attendees-sample-total span").text,
            :hosted_by => @doc.search("div.event-info-hosts-text span.text--secondary span.link").text,
            :how_often => @doc.search("div.eventTimeDisplay p")[0].text,
            :location => @doc.search("p.venueDisplay-venue-address").text,
            :how_to_find_us => @doc.search("div.venueDisplay-venue-howToFindUs p.text--caption").text
            # :click_here_to_rsvp => @doc.children.children[0].children[13].attributes['content'].value
            }            
    end
end