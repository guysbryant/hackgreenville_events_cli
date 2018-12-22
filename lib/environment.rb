require_relative "../lib/hackgreenville_events_cli/version"
require_relative "../lib/hackgreenville_events_cli/cli"
require_relative "../lib/hackgreenville_events_cli/scraper"
require_relative "../lib/hackgreenville_events_cli/events"

require 'pry'
require 'open-uri'
require 'nokogiri'
require 'colorize'


module HackgreenvilleEventsCli
  class Error < StandardError; end
  # Your code goes here...
end
