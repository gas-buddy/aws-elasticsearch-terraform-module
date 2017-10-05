#!/usr/bin/env ruby

require 'erb'

Dir.glob('*.erb').each do |tmpl|
  result = ERB.new(File.read(tmpl), nil, '-').result
  output_filename = tmpl.sub(/\.erb$/, '')
  File.open(output_filename, 'w') { |f| f.write result }
end
