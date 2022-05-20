class Rental
  attr_accessor :date
  attr_reader :book, :person

  def initialize(date, person, book)
    super()
    @date = date
    @book = book
    book.rental.push(self) unless book.rental.include?(self)
    @person = person
    person.rental.push(self) unless person.rental.include?(self)
  end
end
