require 'ap'

file = File.open("day6_input.txt")
input = file.read.split("\n")

def all_direct_orbits(input)
  orbits = {}
  input.each do |orbit|
    a, b = orbit.split(")")
    orbits[b] = a
  end
  return orbits
end

def find_orbits_count(input)
  count = 0
  orbits = all_direct_orbits(input)
  orbits.each do |obj, _other|
    while orbits[obj]
      obj = orbits[obj]
      count += 1
    end
  end
  return count
end

ap find_orbits_count(input)