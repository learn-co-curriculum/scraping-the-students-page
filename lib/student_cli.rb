def run(students)
  puts "Welcome to the Flatiron-007 Student Page!"
  help
  command = nil
  while command != 'exit'
    command = gets.downcase.strip

    case command
    when 'list'
      puts "\n"
      list(students)
    when 'student'
      puts "\nPlease enter the student name:"
      input = gets.downcase.strip
      student(input, students)
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

def list(students)
  students.each do |student|
    puts "#{student[:name]}"
  end
  help
end
