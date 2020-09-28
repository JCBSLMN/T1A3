require "csv"
require "tty-prompt"

prompt = TTY::Prompt.new

loop = true

while loop == true
store_select = prompt.select("what would you like to do?", %w(View_Orders Notify_Customers Edit_Products))

    if store_select == 'View_Orders'
        data = CSV.read("Orders.csv", :headers => true)
        data.each do |row|
        puts "Product: #{row['product']}, Quantity: #{row['qty']}, Phone Number: #{row['phoneNumber']}"
        end
    
        else_select = prompt.yes?('Anything else?')
    
        if else_select == 'Yes'
            puts "Okay,"
        end

        if else_select == 'No'
        loop = false
        end
    end
    

    if store_select == 'Notify_Customers'
        puts 'What was delivered?'
        delivery = gets
        else_select = prompt.yes?('Anything else?')
    
        if else_select == 'Yes'
            puts "Okay,"
        end

        if else_select == 'No'
        loop = false
        end
    end

    if store_select == 'Edit_Products'
        edit_select = prompt.select("what would you like to do?", %w(Remove_product Add_product))
            else_select = prompt.yes?('Anything else?')
    
            if else_select == 'Yes'
                puts "Okay,"
            end
    
            if else_select == 'No'
            loop = false
            end
    end

end