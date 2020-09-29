require_relative "class.rb"
require "csv"
require "tty-prompt"
prompt = TTY::Prompt.new
system('clear')

user_select = prompt.select("Welcome to notifier, what are you?", %w(Store_user Customer_user))
system('clear')

loop = true
if user_select == 'Store_user'
    
    while loop == true
        orders = Csv.new("Orders.csv")
        prods = Csv.new("Products.csv")
        puts store_select = prompt.select("what would you like to do?", %w(View_Orders Notify_Customers Edit_Products))
        if store_select == 'View_Orders'
            puts orders.data
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
            system('clear')
            puts 'Current Products:'
            puts ""
            puts prods.data
            puts""
            puts "Enter the number of the product that was delivered:"
            num = gets.chomp.to_i
            puts "Enter how many were delivered:"
            amount = gets.chomp.to_i
            n = 0
            orders.each do |row|
                if "#{row["product"]}" == "#{prods[num - 1]["prod"]}" && amount >= "#{row["quantity"]}".to_i
                    #send sweet text message to phone number
                    puts "notified!"
                    amount = amount - "#{row["quantity"]}".to_i 
                    row.delete("n")
                end
                n += 1
            end    
            puts "Customers have been notified"
            puts ""

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
            system('clear')
            puts 'Current Products:'
            puts ""
            puts prods.data
            puts ""

            edit_select = prompt.select("What would you like to do?", %w(Remove_product Add_product))

            if edit_select == 'Add_product'
                puts "What is the name of the product you want to add?"
                new_prod = gets.chomp
                n = 0
                prods.data.each do |row|
                    n += 1
                end
                prods.close("Products.csv", [n + 1, new_prod])
            end
            
            if edit_select == 'Remove_product'
                puts "Enter the number of the product you'd like to remove:"
                num = gets.chomp.to_i 
                prods.remove(num)
            end

            
            
            else_select = prompt.select('Anything else?', %w(yes no))
            if else_select == 'yes'
            end
            if else_select == 'no'
                puts "Good-bye."
                loop == false
                break
            end
        end
    end
end




#customer function

if user_select == 'Customer_user'
    orders = Csv.new("Orders.csv")
    prods = Csv.new("Products.csv")
    puts "Welcome to Notifier"
    puts ""
    puts "These are our current products:"
    puts prods.data
    puts ""
    puts "Enter the number of the product you'd like to order:"
    num = gets.chomp.to_i
    system('clear')
    puts "You are ordering #{prods.data[num - 1]["product"]}" 
    puts ""
    puts "Enter the quantity you'd like to order:"
    amount = gets.chomp
    puts ""
    puts "Enter the number you'd like to be notified on:"
    ph = gets.chomp
    system('clear')
    puts "Your order of #{amount} #{prods.data[num - 1]["product"]} has been entered."
    puts ""
    puts "You will recieve a notification on #{ph} when ready."
    puts ""
    puts "Good-bye."
    orders.close("Orders.csv", [prods.data[num - 1]["product"],amount,ph])
end   