require_relative './class.rb'

orders = Csv.new("Orders.csv")


puts orders.data[1]["product"]



