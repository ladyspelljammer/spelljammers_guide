#!/usr/bin/env ruby
#
# Originally written by http://redartisan.com/tags/csv
# Added and minor changes by Gavin Laking
# Rewritten by Andrew Bennett for Ruby 1.9
#
# Usage: ruby csv_to_fixture.rb file.csv [--json]
#
# "id","name","mime_type","extensions","icon_url"
# "1","unknown","unknown/unknown","||","/images/icon/file_unknown.gif"
# "2","image/tiff","image/tiff","|tiff|tif|","/images/icon/blank.png"
#
# if you want to remove the id: "number" line from the resulting YAML file
# do a find and replace for: ^( id: \"\d*\"\n) in Textmate

require 'csv'
require 'yaml'

file = STDIN.read

data = CSV.parse(file, quote_char: '"', force_quotes: true)
#data = CSV.parse(file, :headers => true).map(&:to_hash)
#data1 = CSV.parse(file, :headers => true).map { |row| row[0] }
#puts file

data[0][0] = "Name:"

data.transpose.drop(1).each_with_index do |row|
  unless row[0].to_s.strip.empty?
    puts "    #{row[0]}:"
    row.each_with_index do |col, i|
      puts "      #{data[i][0]} #{col}"
    end
  end
end



=begin
fields = doc.shift
records = Hash.new
doc.each_with_index do |row, i|
  record = Hash.new
  fields.each_with_index do |field, j|
    record[field] = row[j]
  end
  records["record_#{i}"] = record
end

flag = ARGV.shift unless input.nil?
flag ||= input || '--yaml'

case flag
when '--json' then
  puts records.to_json
else
  puts records.to_yaml
end
=end
