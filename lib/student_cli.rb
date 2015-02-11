def run(students)
  puts "Welcome to the Flatiron-007 Student Page!"
  help
  command = nil
  while command != 'exit'
    command = gets.downcase.strip

    case command
    when 'list'
      puts "\n"
      list(info)
    when 'student'
    when 'help'
      help
    when 'exit'
      puts "\nGoodbye!"
    else
      puts "\nThat's not a valid command."
      help
    end
  end
end

def help
  puts "\nWhat would you like to do?"
  puts "The 'list' option lists all students."
  puts "The 'student' option shows student information."
  puts "The 'help' option shows the list of commands."
  puts "The 'exit' option exits the program."
end
