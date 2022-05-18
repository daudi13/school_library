require './nameable'

class Person < Nameable
  attr_accessor :name, :age
  attr_writer :id
  attr_reader :rental

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rental = []
  end

  def of_age?
    @age >= 18
  end

  private :of_age?

  def can_use_service?
    of_age || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    Rental.new(book, date, self)
  end
end
