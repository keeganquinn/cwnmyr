#!/usr/bin/env ruby
# cwnmyr / Personal Telco configuration generator
# © 2011 Personal Telco Project, Inc.

# Connects to wiki to retrieve configuration data

require 'getoptlong'
require 'net/http'


# Command line options
opts = GetoptLong.new(
  [ '--help', '-h', GetoptLong::NO_ARGUMENT ],
  [ '--node', '-n', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--host', '-H', GetoptLong::REQUIRED_ARGUMENT ]
)

# Variables to be populated based on command line
node = nil
host = nil

# Process command line options
opts.each do |opt, arg|
  case opt
  when '--help'
    puts 'help infoz'
    exit 0
  when '--node'
    node = arg
  when '--host'
    host = arg
  end
end

# Ensure node and host have been specified
unless node and host
  puts 'Node and host must be specified.'
  exit 1
end


# URI to gather data from; change this if you're not PTP
uri = URI.parse("http://personaltelco.net/wiki/#{node}?action=raw")

# Connect via HTTP and get a response from the server
res = Net::HTTP.get_response(uri)

# Extract the node name from the top of the page
node_name = res.body[/Node name:\'\'\' (.*) \<\<BR\>\>/, 1]

# Parse through the page to get the requested host section
go = false
host_section = res.body.split("\r\n").select do |l|
  go = true if l =~ /\* Host: `#{host}`/
  go = false if l == ''
  go
end
host_section = host_section.join("\n")

# Extract desired configuration bits into variables
hardware = host_section[/Hardware: (.*)/, 1]
internet_network = host_section[/Internet network: (.*)/, 1]
public_network = host_section[/Public network: (.*)/, 1]


# Tell the nice user what we've done
puts "#{node}: #{node_name} - #{host} (#{hardware})"
puts "Internet: #{internet_network}"
puts "Public: #{public_network}"

# kthxbye
exit 0
