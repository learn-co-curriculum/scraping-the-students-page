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
    student_page.css('.home-blog-post').each do |student_section|
      name = student_section.css('.big-comment a').text
      page_url = STUDENT_URL + student_section.css('.blog-thumb a')[0].attr('href')
      tag_line = student_section.css('.home-blog-post-meta')[0].text
      excerpt = student_section.css('.excerpt p')[0].text
      student = Student.new(name, page_url, tag_line, excerpt)
      students << student
    end
    students
  end
end
