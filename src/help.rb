

def usage
    puts 
        "Steps to install the application -
        This application can be downloaded from GitHub. 
        Once you have downloaded you branch and navigated to the folder, the file can be run from the terminal with the insturction 'ruby main.rb' if you'd prefer to install all required gems yourself. 
        These can be found listed in the dependencies below.

        Arguements can be passed when running the file:
        - Passing '-h' or '--help' following 'ruby main.rb' will display a help menu.
        - Passing '-s' will open in store mode
        - Passing '-c' will open in customer mode

        An exectubale has been made that can install the required gems for you. This can be run once you have navigated to the correct folder and can be run with the command './run_file.sh'


        Any dependencies required by the application to operate -
        gems -
        tty, ~> 0.7.0
        rspec, ~> 3.9
        tty-prompt, ~> 0.12.0
        colorize, ~> 0.8.1
        mail, ~> 2.7
        tty-spinner, ~> 0.4.1

        ruby -
        ruby 2.6.3p62

        Any system/hardware requirements -
        OS - 
        - Only tested on macOS Catalina Version 10.15.6. May not be compatible on other OS.

        minimum hardware requirements:
        - 8 MHz 68000 processor 
        - 128k of RAM 
        - and a 400k disk drive
    "
end
