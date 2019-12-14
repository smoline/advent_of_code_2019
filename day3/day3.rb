require 'ap'
require 'set'

input1 = %{R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83}

input2 = %{R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7}

file = File.open("day3_input.txt")
input = file.read

def walk(path)
  visited = Set.new
  x, y = 0, 0

  path.split(",").each do |instr|
    dir = instr[0]
    steps = instr[1..].to_i

    steps.times do
      case dir
      when "U"
        y += 1
      when "D"
        y -= 1
      when"L"
        x -= 1
      when "R"
        x += 1
      end

      visited.add [x,y]
    end
  end

  visited
end

path_one, path_two = input1.split("\n")

intersection_one = walk(path_one) & walk(path_two)

puts intersection_one.
  map { |x, y| x.abs + y.abs }.
  min

path_three, path_four = input2.split("\n")

intersection_two = walk(path_three) & walk(path_four)

puts intersection_two.
  map { |x, y| x.abs + y.abs }.
  min

path_five, path_six = input.split("\n")

intersection_three = walk(path_five) & walk(path_six)

puts intersection_three.
  map { |x, y| x.abs + y.abs }.
  min

def walk_another(path)
  visited = {}
  x, y = 0, 0
  step = 1

  path.split(",").each do |instr|
    dir = instr[0]
    steps = instr[1..].to_i

    steps.times do
      case dir
      when "U"
        y += 1
      when "D"
        y -= 1
      when"L"
        x -= 1
      when "R"
        x += 1
      end

      visited[[x,y]] = step unless visited[[x,y]]
      step += 1
    end
  end

  visited
end

path_one, path_two = input1.split("\n")

visited_one = walk_another(path_one)
visited_two = walk_another(path_two)

intersection_one = visited_one.keys & visited_two.keys

puts intersection_one.
  map { |x, y| visited_one[[x,y]] + visited_two[[x,y]] }.
  min

path_three, path_four = input2.split("\n")

visited_three = walk_another(path_three)
visited_four = walk_another(path_four)

intersection_two = visited_three.keys & visited_four.keys

puts intersection_two.
  map { |x, y| visited_three[[x,y]] + visited_four[[x,y]] }.
  min

path_five, path_six = input.split("\n")

visited_five = walk_another(path_five)
visited_six = walk_another(path_six)

intersection_three = visited_five.keys & visited_six.keys

puts intersection_three.
  map { |x, y| visited_five[[x,y]] + visited_six[[x,y]] }.
  min