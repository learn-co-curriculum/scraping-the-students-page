require 'open-uri'

class Scraper
  STUDENT_URL = "http://ruby007.students.flatironschool.com/"

  def initialize(student_array)
    @students = student_array
  end

  def students
    @students
  end

  def student_page
    Nokogiri::HTML(open(STUDENT_URL))
  end

  def scrape_student_data
    student_page.css('.home-blog-post').each do |student_page|
      student_hash = {}
      student_hash[:name] = student_page.css('.big-comment a').text
      student_hash[:page_url] = student_page.css('.blog-thumb a')[0].attr('href')
      student_hash[:tag_line] = student_page.css('.home-blog-post-meta')[0].text
      student_hash[:excerpt] = student_page.css('.excerpt p')[0].text
      students << student_hash
    end
  end
end
