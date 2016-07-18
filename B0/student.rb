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

	#生成随机字串
	def random_str()
		#rand(36 ** rand(3..5)).to_s(36)
		[*('a'..'z'),*('A'..'Z'),*(0..9)].shuffle[3..6].join
	end

	#循环生成器100个学生
	def add_stu()
		stus = Array.new(100){|i|}
	end

	def newpass(len)
  	newpass = ""
  	1.upto(len){ |i| newpass << rand(10).to_s}
  	return newpass
	end

end

#test
stu1 = Student.new(1,"John","male",66)
puts "Hello World!"
stu1.info()
puts stu1.random_str()
puts stu1.newpass(3)
