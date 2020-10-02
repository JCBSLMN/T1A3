require_relative "class.rb"
require_relative "mailgem.rb"
require "csv"
require "tty-prompt"
require "colorize"
require "mail"
require "tty-spinner"
prompt = TTY::Prompt.new
system('clear')

user_select = prompt.select("Welcome to the biscuit factory, what are you?".colorize(:color => :white, :background => :red), %w(Store_user Customer_user))
system('clear')

loop = true
if user_select == 'Store_user'
    
    while loop == true
        orders = Csv.new("Orders.csv")
        prods = Csv.new("Products.csv")
        puts store_select = prompt.select("what would you like to do?".colorize(:color => :white, :background => :red), %w(View_Orders Notify_Customers Edit_Products))
        if store_select == 'View_Orders'
            puts orders.data
            else_select = prompt.select('Anything else?'.colorize(:color => :white, :background => :red), %w(yes no))
            if else_select == 'yes'
            end
            if else_select == 'no'
                puts "Good-bye".colorize(:color => :white, :background => :red)
                loop == false
                break
            end      
        end

        if store_select == 'Notify_Customers'
            system('clear')
            puts 'Current Products:'.colorize(:color => :white, :background => :red)
            puts ""
            puts prods.data
            puts""
            puts "Enter the number of the product that was delivered:".colorize(:color => :white, :background => :red)
            num = gets.chomp.to_i
            puts "Enter how many were delivered:".colorize(:color => :white, :background => :red)
            amount = gets.chomp.to_i
            spinner = TTY::Spinner.new
            spinner.run do |spinner|
            orders.data.each do |order|
                n = 0
                if order["product"] == prods.data[num - 1]['product'] && amount >= order["quantity"].to_i
                    Mail.deliver do
                        from     'jacobsolomonow@gmail.com'
                        to       "#{order["email"]}"
                        subject  'Order is ready'
                        body     "Your order of #{order["quantity"]} #{order["product"]} can be picked up."
                    end
                    orders.data.delete(n)
                    amount = amount - "#{order["quantity"]}".to_i 
                    else
                    n += 1
                end 
            end         

            CSV.open("Orders.csv", "w+") do |csv|
                csv << ["product", "quantity", 'email']
                orders.data.each do |row|
                csv << [row["product"], row["quantity"], row["email"]]
                end
            end
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
loop = true
if user_select == 'Customer_user'
    while loop == true
        orders = Csv.new("Orders.csv")
        prods = Csv.new("Products.csv")
        puts "Welcome to the biscuit factory!"
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
        puts "Enter the email you'd like to be notified on:"
        ph = gets.chomp
        system('clear')
        puts "Your order of #{amount} #{prods.data[num - 1]["product"]} has been entered."
        puts ""
        puts "You will recieve a notification on #{ph} when ready."
        puts ""
        orders.close("Orders.csv", [prods.data[num - 1]["product"],amount,ph])
        else_select = prompt.select('Anything else?', %w(yes no))
            if else_select == 'yes'
            end
            if else_select == 'no'
                puts""
                puts "Good-bye."
                loop == false
                break
            end
        end
    end        
