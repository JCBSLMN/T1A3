# require_relative "../main.rb"
require_relative "../class.rb"
require 'csv'


describe 'Csv' do
    it 'it should contain data' do
        csv = Csv.new('Orders.csv')
        expect(csv.data).not_to eql(nil)
        csv = Csv.new('Products.csv')
        expect(csv.data).not_to eql(nil)
    end
end

describe 'select product' do
    it 'it should select the right product' do
        orders = Csv.new('Orders.csv')
        prods = Csv.new("Products.csv")
        num = 1
        expect(prods.data[num - 1]["product"]).to eql('vanilla')
        num = 2
        expect(prods.data[num - 1]["product"]).to eql('choc-chip')
        num = 3
        expect(prods.data[num - 1]["product"]).to eql('oat')
    end
end


describe 'add producst to list' do
    it 'new product should be added to list' do
        prods = Csv.new("Products.csv")
        new_prod = "test"
                n = 0
                prods.data.each do |row|
                    n += 1
                end
                prods.close("Products.csv", [n + 1 , new_prod])
                prods = Csv.new("Products.csv")
                expect(prods.data[n ]["product"]).to eql("test")
        
    end
    it 'product should be added to list with number' do
        prods = Csv.new("Products.csv")
        new_prod = "test"
                n = 0
                prods.data.each do |row|
                    n += 1
                end
                prods.close("Products.csv", [n + 1 , new_prod])
                prods = Csv.new("Products.csv")
                expect(prods.data[n ]["number"]).to eql((n+1).to_s)
        
    end
end

describe 'order contains email' do
    it 'emails should contain @' do
    orders = Csv.new('Orders.csv')
    prods = Csv.new("Products.csv")
    expect(orders.data[1]["email"]).to include('@')
    expect(orders.data[2]["email"]).to include('@')
    expect(orders.data[3]["email"]).to include('@')
    expect(orders.data[4]["email"]).to include('@')
end
end