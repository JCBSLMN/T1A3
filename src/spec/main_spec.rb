# require_relative "../main.rb"
require_relative "../class.rb"
require 'csv'


describe 'Csv' do
    it 'it should contain data' do
        csv = Csv.new('Orders.csv')
        expect(csv.data).not_to eql(nil)
    end
end

describe 'select product' do
    it 'it should select the right product' do
        orders = Csv.new('Orders.csv')
        prods = Csv.new("Products.csv")
        num = 1
        expect(prods.data[num - 1]["product"]).to eql('vanilla')
    end
end

describe 'order product' do
    it 'should order the right amount of product' do
        orders = Csv.new('Orders.csv')
        prods = Csv.new("Products.csv")
        num = 1
        expect(prods.data[num - 1]["product"]).to eql('vanilla')
    end
end

describe 'order contains email' do
    it 'emails should contain @' do
    orders = Csv.new('Orders.csv')
    prods = Csv.new("Products.csv")
    expect(orders.data[1]["email"]).to include('@')
end
end