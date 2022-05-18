class Book 
    attr_accessor :title, :author
    attr_reader :rental

  def initialize(title, author)
    @title = title
    @author = author
  end

  def add_rental(rental)
    @rental.push(rental)
    rental.book = self
  end
end