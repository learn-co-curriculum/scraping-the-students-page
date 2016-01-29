

## Scraping the Students Website

This lab is straightforward but free form. Scrape the [students website](http://fellows.flatironschool.com/) you guys deployed to.  We're looking for you and your group (the table you're sitting at) to make a command line app that is built on top a Nokogiri scraper that will be able to accept and respond to user input.  This might mean _crawling_, moving from one website to another.  That is, entering a student's name and being able to visit their profile.  What information should be available is totally up to you.  That might be a student's name.  A link to something on their profile.  Some text from a page.  Who knows?

This lab will be more free form in that it is not test driven.  So method and variable names are up to you.  The entire structure of the program is up to you.

That being said, here are some sensible guidelines you should consider (__which don't have to be followed__):
- Keep method and variable names sensible and semantic.
  - This will come in handy when debugging and working with others.
- Use helper methods so one method isn't doing all the work.
  - The idea of helper methods is that each method should be responsible for only one thing.
  - It's okay to have a method that delegates tasks to other methods.
- Make sure you're keeping track of your data.
  - You are not going to be persisting (storing in a database) any of the data you scrape, so storing them in variables is a must.
  - Remember that once a variable is out of scope or it's value overwritten, it's gone.
- Try to make a class
  - It will keep your code cleaner.
  - It will facilitate the movement of variables between methods.
    - [`attr_accessor`, `attr_writer`, and `attr_reader`](http://stackoverflow.com/questions/4370960/what-is-attr-accessor-in-ruby) will be very helpful if you use a class.

Now, that you've read the guidelines feel free to disregard any or all of them as you see fit.  ___Make it work, make it right, make it fast. -[KentBeck](http://c2.com/cgi/wiki?KentBeck)___

#### What you and your group must do.

One person should fork and clone this repo, creating a team repo and then everyone else should clone that fork. When your team is done (done is what you decide it is) submit a pull request from the fork back to master.

#### Couple of hints...

There are three components to this lab. You will need to build a command line application (just like you have done with [Guessing CLI](http://learn.flatironschool.com/lessons/10697) and [Jukebox CLI](http://learn.flatironschool.com/lessons/10695)) and a scraper that will scrape the student page for details that you feel are pertinent. Additionally, you can create a object-oriented student class if you're feeling bold!

For the __command line__ component, you could go implement something like this...

```
# bin/run_student_cli

student_hash = create_student_hash
run(student_hash)
```

```
# lib/student_cli.rb

def run(student_hash)
  puts "Welcome to the Octocats Student Page!"
  help
  command = nil
  while command != 'exit'
    command = gets.downcase.strip

    ...
  end
end
```

And then for the __scraper__ component...

```
# lib/scraper.rb

def create_student_hash
  html = open('http://web0415.students.flatironschool.com/')
  profile_data = Nokogiri::HTML(html)  
  students = {}

  profile_data.css("div.big-comment h3 a").each_with_index do |student,i|

    ...organize data into respective key-value pairs...

  end
  students
end
```

How you want to approach the scraping project is _completely_ up to you, but if you're absolutely stuck, this is a good model to follow. If you're still unsure how to proceed, please come find a TA for help! This is one of the first projects that's somewhat self-directed within your groups, so it is definitely a big challenge.

### Nokogiri

Nokogiri is a ruby gem that is designed specifically for scraping websites.  Nokogiri will parse the infromation into XML nodes, which will allow you to move through the document by selecting nodes based on CSS selectors methods.

#### This lab assumes you have done the assigned reading on Nokogiri, here are the links in case you need refeshing.
- [Scraping Kick Starter](http://learn.flatironschool.com/lessons/9892)
- [Bastard's guide to scraping](http://ruby.bastardsbook.com/chapters/html-parsing/)
- [Nokogiri's Documentation](http://nokogiri.org/)

### Troubleshooting Nokogiri

If you're having problems installing Nokogiri and getting an error that says `libiconv is missing`. Run `ls /usr/lib/ | grep libiconv` in your command line and you should see something like this:

```
libiconv.2.4.0.dylib
libiconv.2.dylib
libiconv.dylib
```

If you don't, ask a TA for help.

If you do run these three commands:

```
brew update
brew link libiconv
gem install nokogiri -- --with-iconv-dir=/usr/local/Cellar/libiconv/1.13.1
```

If those `brew link libiconv` fails, ask a TA for help.

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/scraping-the-students-page' title='Scraping the Students Website'>Scraping the Students Website</a> on Learn.co and start learning to code for free.</p>
