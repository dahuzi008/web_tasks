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

	def info
		return "#{@id} #{@name} #{@gender} #{@age}"
	end

	#生成随机字串
	def random_str
		#rand(36 ** rand(3..5)).to_s(36)
		[*('a'..'z'),*('A'..'Z'),*(0..9)].shuffle[3..6].join
	end

	#生成随机数字串
	def newpass(len)
  	newpass = ""
  	1.upto(len){ |i| newpass << rand(10).to_s}
  	return newpass
	end

	#将students数据存到文件中
	def self.store_stu(students)
		stu_file = File.new("student.yml","w+")
		j = 0
		while j< students.length
			stu_file.syswrite(students[j].info)
			stu_file.syswrite("\n")
			j += 1
		end
		stu_file.close
	end

	i = 0
	if File::exists?("student.yml")
		#变量 arr 是一个数组。文件 input.txt 的每一行将是数组 arr 中的一个元素。因此，arr[0] 将包含第一行
		arr = IO.readlines("student.yml")
		students = Array.new
		while i < arr.length
			str = arr[i].split
	    students[i] = Student.new(str[0].to_i, str[1], str[2].to_i, str[3].to_i)#to_i 转化成数字
	    i += 1
	  end

	else
		students = Array.new(100){Student.new(nil,nil,nil,nil)}
		while i< 100
			students[i].id = i+1
			students[i].name = students[i].random_str
			students[i].age = rand(15..20)
			students[i].gender = rand(2)

			i += 1
		end
		store_stu(students)
	end

end

#test
stu1 = Student.new(1,"John","male",66)
puts "Hello World!"
stu1.info()
puts stu1.random_str()
puts stu1.newpass(3)
