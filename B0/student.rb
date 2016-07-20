#!/usr/bin/ruby
class Array
  def sort_by(sysm)
    self.sort{|x,y| x.send(sysm) <=> y.send(sysm)}
  end
end

class Student
  attr_accessor :id, :name, :gender, :age
  @@max_id = 0

  def initialize(id,name,gender,age)
    @id = id
    @name = name
    @gender = gender
    @age = age
  end

#通过p 数组名 来获得[value1 value2]
  def inspect
    "#{@id} #{@name} #{@gender} #{@age}"
  end

  def info
    "#{@id} #{@name} #{@gender} #{@age}"
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
    newpass
  end

#将students数据存到文件中
  def self.store_stu(students)
    if File::exists?("student.yml")
      stu_file = File.new("student.yml","w+")
    else
      stu_file = File.open("student.yml","w+")
    end

    j = 0
    while j< @@max_id
      stu_file.syswrite(students[j].info)
      stu_file.syswrite("\n")
      j += 1
    end
      stu_file.close
  end

  i = 0
  if File::exists?("student.yml")
	#如果文件存在，就直接读入
    arr = IO.readlines("student.yml")#变量 arr 是一个数组。文件 input.txt 的每一行将是数组 arr 中的一个元素。因此，arr[0] 将包含第一行
    students = Array.new
    while i < arr.length
      str = arr[i].split
      students[i] = Student.new(str[0].to_i, str[1], str[2].to_i, str[3].to_i)#to_i 转化成数字
      i += 1
    end
    @@max_id = arr.length
  else
    students = Array.new(100){Student.new(nil,nil,nil,nil)}
	#随机生成100个学生
	# while i< 100
	#  code
	# 	i += 1
	# end
    100.times do |i|
	# 这里的i是从0开始到99的
      students[i].id = i+1
      students[i].name = students[i].random_str
      students[i].age = rand(15..20)
      students[i].gender = rand(2)
    end
    @@max_id = 100
    store_stu(students)
  end

#排序输出功能，按照id和age以及name首字母排序
  def self.order_id(students)
    students = students.sort_by(:id)
    store_stu(students)
  end

  def self.order_age(students)
    students = students.sort_by(:age)
    store_stu(students)
  end

  def self.order_name(students)
    students = students.sort_by(:name)
    store_stu(students)
  end
#测试排序
#order_id(students)
# order_name(students)
# order_age(students)

#增删改查
  def self.add_stu(students)
    puts "请输入学生的name,gender('0'->male;'1'->fomale),age:(用空格隔开)"
    msg = gets
    str = msg.split
    students[@@max_id] = Student.new(@@max_id+1, str[0], str[1].to_i, str[2].to_i)#to_i 转化成数字

    #增加就在末尾添加就行
    aFile = File.open("student.yml", "a")
    j = @@max_id
    aFile.syswrite(students[j].info)
    aFile.syswrite("\n")
    aFile.close
    #puts @@max_id
    @@max_id += 1
  end

  def self.delete_stu(students)
    puts "请输入要删除的学生id："
    msg = gets
    delete_id = msg.to_i
    students[delete_id-1] = Student.new(delete_id,nil,nil,nil)
    puts @@max_id
    store_stu(students)
  end

  def self.edit_stu(students)
    puts "请输入要编辑的学生id："
    msg = gets
    edit_id = msg.to_i
    puts "请输入学生修改后的name,gender('0'->male;'1'->fomale),age:(用空格隔开)"
    val = gets
    str = val.split
    students[edit_id-1] = Student.new(edit_id,str[0], str[1].to_i, str[2].to_i)
    store_stu(students)
  end

  def self.inqury_stu(students)
    p students
  end
#测试增删改查
#add_stu(students)
#delete_stu(students)
#edit_stu(students)
#inqury_stu(students)

end

#test
# stu1 = Student.new(1,"John","male",66)
# puts "Hello World!"
# stu1.info()
# puts stu1.random_str()
# puts stu1.newpass(3)
