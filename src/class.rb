require "csv"

class Csv
    attr_reader :data
    def initialize(filename)
        @data = CSV.parse(File.read(filename), headers: true)
    end

    def close(filename, row)
        CSV.open(filename, "a") do |csv|
            csv << row 
        end
    end

end




# To a file
# CSV.open("path/to/file.csv", "wb") do |csv|
#     csv << ["row", "of", "CSV", "data"]
#     csv << ["another", "row"]
#     # ...
#   end
  

# data = CSV.read("Orders.csv", :headers => true)
            # data.each do |row|
            # puts "Product: #{row['product']}, Quantity: #{row['quantity']}, Phone Number: #{row['phnumber']}"
            # end


