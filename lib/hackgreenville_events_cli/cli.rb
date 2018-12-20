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
        @e = HackgreenvilleEventsCli::Events
        puts "Here are the upcoming events in Greenville, SC: \n\n"
        @e.all.each.with_index(1) do |event, index| 
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
        
        if index >= 0 && index < @e.all.size
            puts "   #{@e.all[index].name}"
            more_info = HackgreenvilleEventsCli::Scraper.new("#{@e.all[index].rsvp_url}").scrape_more_info
            @e.all[index].add_info(more_info)
            puts "   Time: #{@e.all[index].time}\n   RSVP: #{@e.all[index].rsvp_url}\n   Description: #{@e.all[index].description}\n   Number of#{@e.all[index].attendees}\n   Hosted by: #{@e.all[index].hosted_by}\n   How often we meet: #{@e.all[index].how_often}\n   Location: #{@e.all[index].location}\n   How to find us: #{@e.all[index].how_to_find_us}\n   Add to Google: #{@e.all[index].add_to_google_calendar} \n\n"
            
            flag = true
            while flag 
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