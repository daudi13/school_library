require './nameable'
require './person'
require './student'
require './teacher'
require './trimmer_decorator'
require './base_decorator'
require './capitalize_decorator'

person = Person.new(44, "David ouma")
person.correct_name
  capitalizedPerson = CapitalizeDecorator.new(person)
  capitalizedPerson.correct_name
  capitalizedTrimmedPerson = TrimmerDecorator.new(person)