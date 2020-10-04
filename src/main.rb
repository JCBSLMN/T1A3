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
    else_select = prompt.select('Anything else?'.colorize(:color => :white, :background => :red), %w(yes no))
            if else_select == 'yes'
            end
            if else_select == 'no'
                puts "Good-bye".colorize(:color => :white, :background => :red)
                loop == false
                # break
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
        puts store_select = prompt.select("what would you like to do?".highlight, %w(View_Orders Notify_Customers Edit_Products))
        if store_select == 'View_Orders'
            puts orders.data  
            anything_else
        end

        if store_select == 'Notify_Customers'
            clear
            puts "Current Products:\n".highlight
            puts prods.data
            puts "\nEnter the number of the product that was delivered:".highlight
            num = STDIN.gets.chomp.to_i
            puts "Enter how many were delivered:".highlight
            amount = STDIN.gets.chomp.to_i
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
                    puts orders.data
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

            edit_select = prompt.select("\nWhat would you like to do?", %w(Remove_product Add_product))

            if edit_select == 'Add_product'
                puts "What is the name of the product you want to add?"
                new_prod = STDIN.gets.chomp
                n = 0
                prods.data.each do |row|
                    n += 1
                end
                prods.close("Products.csv", [n + 1, new_prod])
            end
            
            if edit_select == 'Remove_product'
                puts "Enter the number of the product you'd like to remove:"
                num = STDIN.gets.chomp.to_i 
                prods.remove(num)
            end

            
            
            anything_else
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
        puts "\nEnter the number of the biscuit you'd like to order:"
        num = STDIN.gets.chomp.to_i
        clear
        puts "You are ordering #{prods.data[num - 1]["product"]} bicuits. \n\n" 
        puts "Enter the quantity you'd like to order:"
        amount = STDIN.gets.chomp
        puts "\nEnter the email you'd like to be notified on:"
        ph = STDIN.gets.chomp
        clear
        puts "Your order of #{amount} #{prods.data[num - 1]["product"]} biscuits has been entered.\n\n"
        puts "You will recieve a notification on #{ph} when ready.\n\n"
        orders.close("Orders.csv", [prods.data[num - 1]["product"],amount,ph])
        anything_else
    end        
end