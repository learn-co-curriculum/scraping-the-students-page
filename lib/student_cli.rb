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
    puts "#{student.name}"
  end
  help
end

def student(input, students)
  students.each do |student|
    if student.name.downcase == input
      puts "\nName: #{student.name}"
      puts "Page URL: #{student.page_url}"
      puts "Tag Line: #{student.tag_line}"
      puts "Excerpt: #{student.excerpt}"
      go_to_page(student)
    end
  end
  help
end

def go_to_page(student)
  puts "Go to #{student.name}'s page? Enter Yes or No."
  input = gets.downcase.chomp
  if input == "yes"
    system("open #{student.page_url}")
  end
end

def help
  puts "\nWhat would you like to do?"
  puts "The 'list' option lists all students."
  puts "The 'student' option shows student information."
  puts "The 'help' option shows the list of commands."
  puts "The 'exit' option exits the program."
end
