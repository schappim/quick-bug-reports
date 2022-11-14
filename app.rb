#!/usr/bin/env ruby

require 'rubygems'
require 'base64'


files = Dir.glob("/Users/admin/code/bug-report/*.png").sort_by {|x| File.mtime(x)}

file_name = files.last

base64_image = File.open("/Users/admin/code/bug-report/#{file_name}", "rb") do |file|
  Base64.strict_encode64(file.read)
end

file_name = '/Users/admin/code/bug-report/url.txt'
file = File.open(file_name, "rb")
url = file.read


file_name = '/Users/admin/code/bug-report/template.html'
file = File.open(file_name, "rb")
template = file.read


template = template.gsub('{{URL}}', url)
output = template.gsub('{{SCREENSHOT}}', "data:image/png;base64, #{base64_image}")

File.open('/Users/admin/code/bug-report/report.html', 'w') { |file| file.write(output) }

`/usr/local/bin/ds /Users/admin/code/bug-report/report.html;`
`rm /Users/admin/code/bug-report/report.html; `
`rm /Users/admin/code/bug-report/*.png`
