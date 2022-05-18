class Book 
    attr_accessor :title, :author
    attr_reader :rental

  def initialize(title, author)
    super()
    @title = title
    @author = author
    @rental = []
  end
end