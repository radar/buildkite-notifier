#!/usr/bin/env ruby
require 'httparty'

token = ENV.fetch("BUILDKITE_TOKEN")
org, pipeline, build_number = ARGV[0..2]
url = "https://api.buildkite.com/v2/organizations/#{org}/pipelines/#{pipeline}/builds/#{build_number}"
state = "unknown"
web_url = nil

print "Waiting for build..."

until ["passed", "failed", "blocked"].include?(state)
  resp = HTTParty.get(url, headers: { "Authorization" => "Bearer #{token}" })
  if resp.code != 200
    puts ""
    puts "Received a #{resp.code} response from Buildkite. Check your arguments are correct."
    exit(1)
  end

  web_url = resp["web_url"]
  state = resp["state"]
  print "."
  sleep(5)
end

message = case state
when "passed"
  "Build passed"
when "failed"
  "Build failed"
end

puts ""
puts message

`terminal-notifier -title 'Build #{build_number}' -message '#{message}' -open '#{web_url}' -appIcon ~/.buildkite/#{state}.png`
