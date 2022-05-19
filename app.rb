require './book'
require './classroom'
require './person'
require './rental'
require './teacher'
require './student'

class App
  attr_accessor :client_input

  def initialize
    puts 'Welcome to School library App!'
    ui_prompt
    @rental = []
    @people = []
    @classroom_default = classroom.new('default-classroom')
    @books = []
    @client_input = gets.chomp
  end

  def ui_prompt 
    puts '
    Please choose an option by entering a number:
    1 - List all books
    2 - List all people
    3 - Create a person
    4 - Create a book
    5 - Create a rental
    6 - list all rentals for a given person id
    7 - Exit
    '
    puts ' '
    puts 'Select an Option: '
  end

  def client_input_valid?(client_input, arr) 
    arr.includes?(client_input)
  end

  def pick_name
    print 'Name: '
    name = gets.chomp
    name.empty? ? pick_name : name
  end

  def pick_age
    print 'Age: '
    age = gets.chomp.to_i
    (1..75).includes?(age) ? age : pick_age
  end

  def get_permission
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    %w[Y N].include?(permission.capitalize) ? permission.capitalize : get_permission
  end

  def get_specialization
    print 'Specialization: '
    specialization = get.chomp
    specialization.empty? ? get_specialization : specialization
  end

  def student_info
    age = pick_age
    name = pick_name
    has_parent_permission = get_permission == 'Y'
    [age, name, has_parent_permission]
  end

  def teacher_info 
    age = pick_age
    name = pick_name
    specialization = get_specialization
    [age, name, specialization]
  end

  def create_person
    print "\nDo you want to create a student(1) or a teacher (2)? [Input the number]: "
    @client_input = gets.chomp
    create_person unless client_input_valid?(client_input, %w[1 2])

    if @client_input == '1'
      age, name, has_parent_permission = student_info
      person = Student.new(age, @classroom_default, name, parent_permission: has_parent_permission)
    else 
      age, name, specialization = teacher_info
      person = Teacher.new(age, specialization, name)
    end

    @people << person
    puts 'Person created successfully'
  end

  def get_title
    print 'Title: '
    title = get.chomp
    title.empty? ? get_title : title
  end

  def get_author
    print 'Author: '
    author = gets.chomp
    author.empty? ? get_author : author
  end

  def create_book 
    print 'Author: '
    title = get_title
    author = get_author
    book = Book.new(title, author)
    @books << book
    puts 'Book Created successfully'
  end

  def list_books
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: \"#{book.author}\""}
  end

  def list_persons
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  
end