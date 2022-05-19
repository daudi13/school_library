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
    puts 
  end
end