require 'SecureRandom'

class Person
  attr_accessor :name, :age
  attr_writer :id

  def initialize(age, name="Unknown", parent_permission: true)
    super()
    @id = SecureRandom.uuid
    @age = age
    @name = name
    @parent_permission = parent_permission
  end

  def is_of_age? 
    @age >= 18
  end

  private :is_of_age?

  def can_use_service? 
    is_of_age || @parent_permission
  end

end