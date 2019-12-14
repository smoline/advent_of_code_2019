require 'ap'

range = (168630..718098)

input1 = 111111

input2 = 223450

input3 = 123789

input4 = 168999

def password(input)
  original = input
  org_arr = input.to_s.chars
  return false unless original == org_arr.sort.join.to_i
  return false unless original != org_arr.uniq.join.to_i
  return true
end

ap password(input1)
ap password(input2)
ap password(input3)
ap password(input4)

ap range.select { |num| password(num) }.length 


# Part 2

input5 = 112233
input6 = 123444
input7 = 111122

def new_password(input)
  original = input
  org_arr = input.to_s.chars
  return false unless original == org_arr.sort.join.to_i
  return false unless original != org_arr.uniq.join.to_i
  num_arr = org_arr.map { |char| char.to_i }
  new_num = num_arr.slice_when { |a, b| a != b }.any? { |run| run.length == 2 }
  return new_num
end

ap new_password(input5)
ap new_password(input6)
ap new_password(input7)

ap range.select { |num| new_password(num) }.length