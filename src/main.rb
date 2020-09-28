require "csv"
require "tty-prompt"

prompt = TTY::Prompt.new

user_select = prompt.select("Welcome to notifier, what are you?", %w(Store_user Customer_user))


loop = true
if user_select == 'Store_user'
    while loop == true
        puts store_select = prompt.select("what would you like to do?", %w(View_Orders Notify_Customers Edit_Products))

        if store_select == 'View_Orders'
            data = CSV.read("Orders.csv", :headers => true)
            data.each do |row|
            puts "Product: #{row['product']}, Quantity: #{row['qty']}, Phone Number: #{row['phoneNumber']}"
            end
        
            else_select = prompt.select('Anything else?', %w(yes no))
    
            if else_select == 'yes'
            end

            if else_select == 'no'
                puts "Good-bye"
                loop == false
                break
            end
            
        end

        if store_select == 'Notify_Customers'
            puts 'What was delivered?'
            delivery = gets
            else_select = prompt.select('Anything else?', %w(yes no))
    
            if else_select == 'yes'
            end

            if else_select == 'no'
                puts "Good-bye"
                loop == false
                break
            end
        end

        if store_select == 'Edit_Products'
            puts "Current products are:"
            prods = CSV.read("Products.csv", :headers => true)
            prods.each do |row|
                puts "#{row}"
            end

            edit_select = prompt.select("what would you like to do?", %w(Remove_product Add_product))
            if edit_select == 'Remove_product'
                remove_select = prompt.select("What product is to be removed?", %w(product_list))
                
            end

            if edit_select == 'Add_product'
                puts "added"
            end
            
            else_select = prompt.select('Anything else?', %w(yes no))
    
            if else_select == 'yes'
            end

            if else_select == 'no'
                puts "Good-bye"
                loop == false
                break
            end
        end
    end
end

if user_select == 'Customer_user'
puts "welcome to Notifier"
puts "Please select what you would like to order"
@arr = [1,4,5]
prod = prompt.select("", @arr)
puts prod
end   