#!/usr/bin/ruby
require 'yaml'
#monkey patch
# class BuffArray < Array
# 	def sort_by(sysm)
#       self.sort{|x,y| x.send(sysm) <=> y.send(sysm)}
#     end
# end
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

end
#生成随机字串
  # def random_str
  #   #rand(36 ** rand(3..5)).to_s(36)
  #   #[*('a'..'z'),*('A'..'Z')].shuffle[3..6].join
  # end

#生成随机字串
  def newpass(len)
    chars = ("a".."z").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass.capitalize
  end

#将students数据存到文件中
  def store_stu(students)
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

  if File::exists?("student.yml")
	#如果文件存在，就直接读入
	#arr = YAML::load(File.open('student.yml'))
	#变量 arr 是一个数组。文件 input.txt 的每一行将是数组 arr 中的一个元素。因此，arr[0] 将包含第一行
    arr = IO.readlines("student.yml")
	#p arr.length
    students = Array.new
    i = 0
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
      students[i].name = newpass(rand(3..6))
      students[i].age = rand(15..20)
      students[i].gender = rand(2)
    end
    @@max_id = 100
    store_stu(students)
  end

#排序输出功能，按照id和age以及name首字母排序
  def order_id(students)
    students = students.sort_by(:id)
    store_stu(students)
  end

  def order_age(students)
    students = students.sort_by(:age)
    store_stu(students)
  end

  def order_name(students)
    students = students.sort_by(:name)
    store_stu(students)
  end
#测试排序
#order_id(students)
#order_name(students)
# order_age(students)

#增删改查
  def add_stu(students)
    puts "请输入学生的name,gender('0'->男;'1'->女),age:(用空格隔开)"
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

  def delete_stu(students)
    puts "请输入要删除的学生id："
    msg = gets
    delete_id = msg.to_i
    students[delete_id-1] = Student.new(delete_id,nil,nil,nil)
    store_stu(students)
  end

  def edit_stu(students)
    puts "请输入要编辑的学生id："
    msg = gets
    edit_id = msg.to_i
    puts "请输入学生修改后的name,gender('0'->男;'1'->女),age:(用空格隔开)"
    val = gets
    str = val.split
    students[edit_id-1] = Student.new(edit_id,str[0], str[1].to_i, str[2].to_i)
    store_stu(students)
  end

  def inqury_stu(students)
    p students
  end
#测试增删改查
#add_stu(students)
#delete_stu(students)
#edit_stu(students)
#inqury_stu(students)

#整合一下
  def manage_stu(students)
    while 1
      puts "请输入操作码："
      puts "1:增  2:删  3:改  4:查  5:排  0:退出"

      opcode = gets
      case opcode.to_i
      when 0
        puts "you're welcome!"
        exit(0)
      when 1
        add_stu(students)
      when 2
        delete_stu(students)
      when 3
        edit_stu(students)
      when 4
        inqury_stu(students)
      when 5
        puts "请选择排序方式："
        puts "1:byID  2:byAge  3:byName  "
        iqcode = gets
        case iqcode.to_i
        when 1
          order_id(students)
        when 2
          order_age(students)
        when 3
          order_name(students)
        else
          puts "输入有误，请重输！"
        end
      else
        puts "输入有误，请重输！"
      end
    end
  end
#test
# stu1 = Student.new(1,"John","male",66)
# puts "Hello World!"
# stu1.info()
# puts stu1.random_str()
# puts stu1.newpass(3)
manage_stu(students)
