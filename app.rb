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

  
end