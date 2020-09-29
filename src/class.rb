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

    def remove(num)
        data.each do |row|
            if row["number"] == num.to_s
                data.delete(num - 1)
            end
        end
        data.each do |row|
            if row["number"] > num.to_s
            row["number"] = row["number"].to_i - 1
            end
        end
        puts data
        CSV.open("Products.csv", "w+") do |csv|
            csv << ["number", "product"]
            data.each do |row|
            csv << [row["number"],row["product"]]
            end
            # csv << ["number,product", data]
        end
    end   
end

