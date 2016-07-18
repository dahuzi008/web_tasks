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

	def info()
		puts "#{@id} #{@name} #{@gender} #{@age}"
	end

end

#test
stu1 = Student.new(1,"John","male",66)
puts "Hello World!"
stu1.info()
