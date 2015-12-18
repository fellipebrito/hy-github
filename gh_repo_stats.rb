#!/usr/bin/env ruby
require 'optparse'
require './app/app.rb'

options = {}

optparse = OptionParser.new do|opts|
  opts.banner = 'Usage: _repo_stats [--after DATETIME] [--before DATETIME] [--event EVENT_NAME] [-n COUNT]'

  opts.on('--after DATE', 'Starting at this date') do | after |
    options[:after] = after
  end

  opts.on('--before DATE', 'Ending at this date') do | before |
    options[:before] = before
  end

  opts.on('--event EVENT', 'type event') do | event |
    options[:event] = event
  end

  opts.on('--count INTEGER', 'total of repos to be shown') do | count |
    options[:count] = count
  end

  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end

optparse.parse!

app = App.new options
puts app.run
