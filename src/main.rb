require_relative "class.rb"
require_relative "mailgem.rb"
require_relative "help.rb"
require "csv"
require "tty-prompt"
require "colorize"
require "mail"
require "tty-spinner"

def anything_else
    prompt = TTY::Prompt.new
    else_select = prompt.select('Anything else?'.highlight, %w(yes no))
            if else_select == 'yes'
                clear
            end
            if else_select == 'no'
                puts "Good-bye".highlight
                loop == false
                exit
            end 
end

def clear
    system('clear')
    puts "NOTIFIER APP\n".highlight

end

class String
    def highlight
        colorize(:color => :white, :background => :red)
    end

    def error
        colorize(:color => :red, :background => :white)
    end
end



user_select = ''

if ARGV.include? "-h"
    usage
    return

elsif ARGV.include? "--help"
    usage
    return

elsif ARGV.include? "-s"
    prompt = TTY::Prompt.new
    user_select = 'Store_user'

elsif ARGV.include? "-c"
    prompt = TTY::Prompt.new
    user_select = 'Customer_user'
    

elsif ARGV[0].nil?
prompt = TTY::Prompt.new
clear
user_select = prompt.select("Welcome to the biscuit factory! What are you?".highlight , %w(Store_user Customer_user))
clear
end

loop = true
if user_select == 'Store_user'
    
    while loop == true
        orders = Csv.new("Orders.csv")
        prods = Csv.new("Products.csv")
        puts store_select = prompt.select("What would you like to do?".highlight, %w(View_Orders Notify_Customers Edit_Products))
        if store_select == 'View_Orders'
            clear
            puts orders.data
            puts "\n"  
            anything_else
        end

        if store_select == 'Notify_Customers'
            clear
            puts "Current Products:\n".highlight
            puts prods.data
            verify_n = false
            while verify_n == false
                puts "\nEnter the number of the product that was delivered:".highlight
                num = STDIN.gets.chomp.to_i
                prods.data.each do |prod| prod["number"].to_i
                    if num == prod["number"].to_i
                        verify_n = true
                        break
                    end
                end
                puts "\nplease enter valid number".error
            end
            clear
            

            verify_d = false
            while verify_d == false
                puts "\nEnter how many were delivered:".highlight
                amount = STDIN.gets.chomp.to_i
                if amount == nil
                    puts "Needs to be a number more than 0  \n\n".error
                elsif amount <= 0
                    puts "Needs to be a number more than 0  \n\n".error
                else
                    verify_d = true 
                end
            end

            # amount = STDIN.gets.chomp.to_i
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
                    amount = amount - order["quantity"].to_i
                    orders.data.delete(n)
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
            puts "Customers have been notified\n"
            anything_else
        end

        if store_select == 'Edit_Products'
            clear
            puts "Current Products:\n"
            puts prods.data

            edit_select = prompt.select("\nWhat would you like to do?".highlight, %w(Remove_product Add_product))

            if edit_select == 'Add_product'
                verify_p = false
                while verify_p == false
                    puts "\nWhat is the name of the product you want to add?"
                    new_prod = STDIN.gets.chomp
                    if new_prod.length > 0
                        verify_p = true 
                    else 
                        puts "Product name should contain something".error
                    end
                end
                    n = 0
                    prods.data.each do |row|
                        n += 1
                    end
                    prods.close("Products.csv", [n + 1, new_prod])
                    anything_else
                
                
            end

            loop2 = true
            if edit_select == 'Remove_product' 
                while loop2 == true
                    puts "\nEnter the number of the product you'd like to remove. Any invalid input will result in nothing being removed:"
                    num = STDIN.gets.chomp.to_i
                    prods.data.each do |prod| prod["number"].to_i
                        if num == prod["number"].to_i
                            prods.remove(num)
                            clear
                            break
                        end
                        loop2 = false
                    end
                    
                end 
                anything_else
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
        clear
        puts "Welcome to the biscuit factory!\n\n"
        puts "These are our current biscuits:\n\n"
        puts prods.data 

        verify_b = false
        while verify_b == false
            puts "\nEnter the number of the biscuit you'd like to order:".highlight
            num = STDIN.gets.chomp.to_i
            prods.data.each do |prod| prod["number"].to_i
                if num == prod["number"].to_i
                    verify_b = true
                    break
                end
            end
            puts "\nplease enter valid number".error
        end
        clear
        puts "You are ordering #{prods.data[num - 1]["product"]} bicuits. \n\n" 

        verify_q = false
        while verify_q == false
            puts "Enter the quantity you'd like to order:".highlight
            amount = STDIN.gets.chomp
            if amount.length == 0 
                puts "Needs to be a number more than 0  \n\n".error
            elsif amount == nil
                puts "Needs to be a number more than 0  \n\n".error
            elsif amount.to_i <= 0
                puts "Needs to be a number more than 0  \n\n".error
            else
                verify_q = true 
            end
        end

        verify_email = false
        while verify_email == false
            puts "\nEnter the email you'd like to be notified on:".highlight
            ph = STDIN.gets.chomp
            if ph.include?('@') && ph.length > 6
                verify_email = true 
            elsif ph.length < 6
                puts "email should be longer".error
            else 
                puts "email should contain an @ symbol".error
            end
        end

        clear
        puts "Your order of #{amount} #{prods.data[num - 1]["product"]} biscuits has been entered.\n\n"
        puts "You will recieve a notification on #{ph} when ready.\n\n"
        orders.close("Orders.csv", [prods.data[num - 1]["product"],amount,ph])
        anything_else
        
    end        
end