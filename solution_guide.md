## Scraping the Students Website

### Starting Out

We need to set up the initial project directory. I ended up going with something like this:

```
├── README.md
|
├── bin
|   └── run_student_cli
|
├── config
|   └── environment.rb
|
├── lib
│   ├── scraper.rb
│   ├── student.rb
│   └── student_cli.rb
│   
├── Gemfile
│   
├── Gemfile.lock
│   
└── spec
    ├── specs
    └── spec_helper.rb

```

#### environment.rb, Gemfile

What's the purpose of our `environment.rb` file? It's a file that stores all of our file and gem dependencies. Basically, everything that the CLI app needs to be able to function and __work__ will be required inside of `environment.rb`. It should look something like this:

```ruby
# environment.rb
require 'bundler/setup'
Bundler.require(:default)

require_relative '../lib/scraper'
require_relative '../lib/student'
require_relative '../lib/student_cli'
```

Our `Gemfile` will also contain a few gems that will help us to scrape the student website. One of the gems we need is `Nokogiri`, and another is `Pry`, which I like to use in order to figure out which elements I need to select via `Nokogiri`, and also to debug.

```ruby
# Gemfile
source "https://rubygems.org"

gem 'pry'
gem 'nokogiri'
```

We are requiring the `Gemfile` dependencies (any gems that we list inside the `Gemfile`), as well as the `scraper`, `student`, and `student_cli` files. Where are we going to require the `environment.rb` file? We will simply require it inside of the `bin/run_student_cli` file. Any time the CLI program runs, it will always have access to the files inside of `environment.rb`. As a result, we now have our dependencies in line.

#### bin/run_student_cli

Now let's start building out our `bin/run_student_cli` executable. I want to initialize an empty array that serves as a collection of students. There are different ways of implementing an initial data store, so I'll start with an array (you could choose to use a hash if you wanted).

```ruby
# bin/run_student_cli
require_relative '../config/environment'

students = []
Scraper.new(students).scrape_student_data
```

We're requiring the dependencies from the `environment.rb` file, and initializing an empty array that is assigned to a variable called `students`. Finally, we are initializing a new instance of the `Scraper` class, and passing in the `students` array. Finally, we are calling the method `#scrape_student_data` on the new scraper instance.

### lib/scraper.rb

Let's go ahead and start setting our scraper up. First off, we need a few things. We need the URL for the student page, we need a Scraper object, and we need to set up a method that will allow us to obtain data via Nokogiri. So let's implement that below.

```ruby
# lib/scraper.rb
class Scraper
  STUDENT_URL = "http://ruby007.students.flatironschool.com/"

  def initialize(student_array)
    @students = student_array
  end

  def students
    @students
  end

  def student_page
    page = Nokogiri::HTML(open(STUDENT_URL))
  end
end
```

Now let's start accessing the elements on the student page. In the scraper class, I defined a method called `scrape_student_data`, and started playing around with Nokogiri and grabbing page data with `binding.pry`.

```ruby
class Scraper
  ...
  def scrape_student_data
    student_page.css('.home-blog-post').each do |student_page|
      student_hash = {}
      binding.pry
    end
  end
  ...
end
```

Eventually I was able to grab the following elements: `name`, `page_url`, `tag_line`, and `excerpt`. The `scrape_student_data` method looks like this:

```ruby
class Scraper
  ...
  def scrape_student_data
    student_page.css('.home-blog-post').each do |student_section|
      student_hash = {}
      student_hash[:name] = student_section.css('.big-comment a').text
      student_hash[:page_url] = student_section.css('.blog-thumb a')[0].attr('href')
      student_hash[:tag_line] = student_section.css('.home-blog-post-meta')[0].text
      student_hash[:excerpt] = student_section.css('.excerpt p')[0].text
      students << student_hash
    end
    students
  end
  ...
end
```

Now our `scrape_student_data` should return us an array of hashes. Each hash in the array will represent a student.

### lib/student_cli.rb

On to the CLI component of the app. Let's start with the basic frame of what our CLI will look like.

```ruby
def run(students)
end

def list(students)
end

def student(input, students)
end

def help
end
```

#### `run`

Let's begin with the `run` method.

```ruby
def run(students)
  puts "Welcome to the Flatiron-007 Student Page!"

  command = nil
  while command != 'exit'
    command = gets.downcase.strip

    case command
    when 'list'
    when 'student'
    when 'help'
    when 'exit'
    else
    end
  end
end
```

This is the backbone of the `run` method. It will take a parameter `students`, which is the students array we made earlier. We want to output the "Welcome" banner when the CLI app is first invoked via `run`. Next we have a `while` loop that's basically taking a user input via `gets.downcase.strip`, and a `case` statement that's handling that user input, depending on whether the command is `list`, `student`, `help`, or `exit`.

#### `help`

What are the next steps? Let's flesh out the `help` method. We want the user, upon invocation of the `run` method, to output a list of instructions on how to use the CLI commands. This would simply print out each of the possible commands, and what it does. Let's see this implemented below:

```ruby
def help
  puts "\nWhat would you like to do?"
  puts "The 'list' option lists all students."
  puts "The 'student' option shows student information."
  puts "The 'help' option shows the list of commands."
  puts "The 'exit' option exits the program."
end
```

Now let's apply this to the `run` method.

```ruby
def run(students)
  puts "Welcome to the Flatiron-007 Student Page!"
  help

  command = nil
  while command != 'exit'
    command = gets.downcase.strip

    case command
    when 'list'
    when 'student'
    when 'help'
      help
    when 'exit'
    else
    end
  end
end
```

Any time the `help` command is the user input, it will output the instructions.

#### `list`

Next, the `list` method will list out all the names of the students. Remember that we've passed in the students array from the Scraper class as an argument for the `students` parameter. We want to pass that into a parameter for the `list` method, as shown below.

```ruby
def list(students)
  students.each do |student|
    puts "#{student[:name]}"
  end
  help
end
```

This will iterate through all of the students, and output their name attribute into the command line. How will it be called in the `run method?`

```ruby
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
    when 'help'
      help
    when 'exit'
    else
    end
  end
end
```

The `"\n"` string will actually create a newline, which gives us a buffer between the `help` output and the `list` output.

#### `student`

Now let's set up the logic for finding a specific student. We need to change the `run` method to accept input for a student:

```ruby
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
    else
    end
  end
end
```

And let's set up the `student` method below.

```ruby
def student(input, students)
  students.each do |student|
    if student[:name].downcase == input
      puts "\nName: #{student[:name]}"
      puts "Page URL: #{student[:page_url]}"
      puts "Tag Line: #{student[:tag_line]}"
      puts "Excerpt: #{student[:excerpt]}"
      go_to_page(student)
    end
  end
  help
end
```

Notice that we have a method called `go_to_page`. This is completely optional, but I included it in there for fun. Here's the `go_to_page` method below.

```ruby
def go_to_page(student)
  puts "Go to #{student[:name]}'s page? Enter Yes or No."
  input = gets.downcase.chomp
  if input == "yes"
    system("open #{student[:page_url]}")
  end
end
```

#### `exit` and `else` cases

Let's finish up the `run` method. When a user exits the CLI, we need to output "Goodbye!". Also, if someone enters in something other than the default inputs, we need to handle those cases by outputting the `help` dialogue.

```ruby
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
```
