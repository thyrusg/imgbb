#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'pathname'
UPLOAD_URL = "https://api.imgbb.com/1/upload"

if ARGV.empty?
  puts "Usage: imgbb [path_to_file]"
  exit 1
end

image_path = Pathname.new(ARGV[0])

imgbb_key = ENV["IMGBB_API_KEY"]

if imgbb_key.nil?
  puts "IMGBB_API_KEY not set. Please set and try again"
  exit 1
end

uri = URI(UPLOAD_URL)
params = {:key => imgbb_key, :name => image_path.to_s}
uri.query = URI.encode_www_form(params)

req = Net::HTTP::Post.new(uri)
req.set_form([['image', File.open(image_path)]], 'multipart/form-data')

res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
  http.request(req)
end

case res
when Net::HTTPSuccess, Net::HTTPRedirection
  url = JSON.parse(res.body)["data"]["url_viewer"]
  puts "Success: #{url}"
else
  puts "Request failed. See error message"
  puts JSON.parse(res.body)
  exit 1
end
