require "open-uri"
require "nokogiri"
class HackgreenvilleEventsCli::CLI
    def start
       puts "Welcome to the HackGreenville Events Gem \n"
       HackgreenvilleEventsCli::Scraper.new("https://hackgreenville.com/events").scrape_events
       list_events 
       menu
    end

    def list_events 
        @events = HackgreenvilleEventsCli::Events
        puts "Here are the upcoming events in Greenville, SC: \n\n"
        @events.all.each.with_index(1) do |event, index| 
            puts "#{index}. #{event.name}\n   Time: #{event.time}\n   RSVP: #{event.rsvp_url}\n   Add to Google: #{event.add_to_google_calendar} \n\n"
        end
    end

    def menu
        puts "Select an event by typing the associated number to get more information about that event or type exit to quit: \n\n"
        input = gets.strip
        if input.class == String
            if input.downcase == "exit"
                quit 
            end
        end

        index = input.to_i - 1
        
        if index >= 0 && index < @events.all.size
            selected_event = @events.all[index]
            puts "   #{selected_event.name}"
            if !selected_event.description 
                more_info = HackgreenvilleEventsCli::Scraper.new("#{selected_event.rsvp_url}").scrape_more_info
                selected_event.add_info(more_info)
            end
            puts "   Time: #{selected_event.time}\n   RSVP: #{selected_event.rsvp_url}\n   Description: #{selected_event.description}\n   Number of#{selected_event.attendees}\n   Hosted by: #{selected_event.hosted_by}\n   How often we meet: #{selected_event.how_often}\n   Location: #{selected_event.location}\n   How to find us: #{selected_event.how_to_find_us}\n   Add to Google: #{selected_event.add_to_google_calendar} \n\n"
            
            while true 
                puts "Type list to display the original list again, or exit to quit\n" 
                input = gets.strip
                if input.class == String
                    if input.downcase == "list"
                        list_events
                        menu
                    elsif input.downcase == "exit"
                        quit
                    else
                        puts "I don't understand\n\n"
                    end
                end
            end
        else 
            puts "I don't understand.\n\n"
            menu
        end
        
    end

    def quit 
        exit!
    end
end