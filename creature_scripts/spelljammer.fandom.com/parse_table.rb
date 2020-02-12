#!/usr/bin/env ruby

require 'nokogiri'
require 'csv'

print_header_lines = true

table_string=$stdin.read
doc = Nokogiri::HTML(table_string)

doc.xpath('//table//tr').each do |row|
  if print_header_lines
    row.xpath('th').each do |cell|
      print '"', cell.text.gsub("\n", ' ').gsub('"', '\"').gsub(/(\s){2,}/m,'\1').strip, "\","
    end
  end
  row.xpath('td').each do |cell|
    print '"', cell.text.gsub("\n", ' ').gsub('"', '\"').gsub(/(\s){2,}/m,'\1').strip, "\","
  end
  print "\n"
end
