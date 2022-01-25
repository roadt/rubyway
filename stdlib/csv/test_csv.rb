

require 'csv'



# a line at a time
CSV.parse("CSV,data,String") do |row|
  print row.length, row
end


CSV.open("test.csv", 'wb') do |csv|
  csv << ['row', 'of', 'CSV', 'data']
  csv << ['another', 'row']
end


CSV.generate do |csv|
  csv << ['row', 'of', 'CSV', 'data']
  csv << ['another', 'row']
end


['CSV','data'].to_csv
"CSV,String".parse_csv




