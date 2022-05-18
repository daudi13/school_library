class Book 
  attr_accessor :title, :author
  def initialize(title, author)
    @title = title
    @author = author
  end

  def add_rental(rental)
    @rental.push(rental)
    rental.book = self
  end
end