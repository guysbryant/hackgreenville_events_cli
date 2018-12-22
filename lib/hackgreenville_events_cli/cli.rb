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
            puts "#{index} " + "#{event.name}".green.bold.underline, "  Time: ".red + "#{event.time}", "  RSVP: ".red + "#{event.rsvp_url}\n\n"
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
            puts "#{selected_event.name}".green.bold.underline
            if !selected_event.description 
                more_info = HackgreenvilleEventsCli::Scraper.new("#{selected_event.rsvp_url}").scrape_more_info
                selected_event.add_info(more_info)
            end
            puts "  Time: ".red + "#{selected_event.time}", "  RSVP: ".red + "#{selected_event.rsvp_url}", "  Description: ".red + "#{selected_event.description}", "  Number of attendees: ".red + "#{selected_event.attendees}", "  Hosted by: ".red + "#{selected_event.hosted_by}", "  How often we meet: ".red + "#{selected_event.how_often}", "  Location: ".red + "#{selected_event.location}", "  How to find us: ".red + "#{selected_event.how_to_find_us}\n\n" 

            while true 
                wrong_input = "\nI don't understand\n\n"
                puts "Type list to display the original list again, or exit to quit\n" 
                input = gets.strip
                if input.class == String
                    if input.downcase == "list"
                        list_events
                        menu
                    elsif input.downcase == "exit"
                        quit
                    else
                        puts wrong_input
                    end
                end
            end
        else 
            puts wrong_input
            menu
        end
        
    end

    def quit 
        exit!
    end
end