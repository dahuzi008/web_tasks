#!/usr/bin/ruby
class Student
	attr_accessor :id
	attr_accessor :name
	attr_accessor :gender
	attr_accessor :age

	def initialize(id,name,gender,age)
		@id = id
		@name = name
		@gender = gender
		@age = age
	end
	
end
	
