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
    @classroom_default = Classroom.new('default-classroom')
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
    arr.include?(client_input)
  end

  def pick_name
    print 'Name: '
    name = gets.chomp
    name.empty? ? pick_name : name
  end

  def pick_age
    print 'Age: '
    age = gets.chomp.to_i
    (1..75).include?(age) ? age : pick_age
  end

  def rip_permission
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    %w[Y N].include?(permission.capitalize) ? permission.capitalize : rip_permission
  end

  def rip_specialization
    print 'Specialization: '
    specialization = gets.chomp
    specialization.empty? ? rip_specialization : specialization
  end

  def student_info
    age = pick_age
    name = pick_name
    has_parent_permission = rip_permission == 'Y'
    [age, name, has_parent_permission]
  end

  def teacher_info
    age = pick_age
    name = pick_name
    specialization = rip_specialization
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

  def rip_title
    print 'Title: '
    title = gets.chomp
    title.empty? ? rip_title : title
  end

  def rip_author
    print 'Author: '
    author = gets.chomp
    author.empty? ? rip_author : author
  end

  def create_book
    print ' '
    title = rip_title
    author = rip_author
    book = Book.new(title, author)
    @books << book
    puts 'Book Created successfully'
  end

  def list_books
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: \"#{book.author}\"" }
  end

  def list_persons
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def rip_specified_book
    puts "\nSelect a book from the following list by number"
    list_books
    specified_book_index = gets.chomp
    (0..@books.length).include?(specified_book_index.to_i) ? specified_book_index.to_i : rip_specified_book
  end

  def rip_specified_person
    puts "\nSelect a person from the following list by number (not id)"
    list_persons
    specified_person_index = gets.chomp
    (0..@people.length).include?(specified_person_index.to_i) ? specified_person_index.to_i : read_desired_person
  end

  def rip_specified_date
    print "\nDate: "
    gets.chomp
  end

  def create_rental
    return print 'Please add a book first' if @books.empty?
    return print 'Please add a person first' if @people.empty?

    books = @books[rip_specified_book]
    person = @people[rip_specified_person]
    date = rip_specified_date

    rental = Rental.new(date, person, books)

    @rental << rental
    puts 'Rental created successfully'
  end

  def create_client(client_input)
    case client_input
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    end
  end

  def list_id_rentals
    return puts 'Please add a rental first' if @rental.empty?

    puts "\nID of person: "
    # @people.each do |person|
    #   puts "ID: #{person.id}, [#{person.class}] Name: #{person.name}, Age: #{person.age}"
    # end
    person_id = gets.chomp.to_i
    rentals = @rental.select { |rent| rent.person.id == person_id }
    if rentals.empty?
      puts 'No rentals found for this person.'
    else
      rentals.each do |rental|
        puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
      end
    end
  end

  def diplay_list(client_input)
    case client_input
    when '1'
      list_books
    when '2'
      list_persons
    when '6'
      list_id_rentals
    end
  end

  def run
    loop do
      case client_input
      when '1', '2', '6'
        diplay_list(client_input)
      when '3', '4', '5'
        create_client(client_input)
      when '7'
        puts 'Thank you for using this app!'
        exit(true)
      else
        puts "\nInvalid input \"#{client_input}\"!"
        puts 'Please try with one of these options: '
        ui_prompt
        @client_input = gets.chomp
        run
      end
      ui_prompt
      @client_input = gets.chomp
    end
  end
end
