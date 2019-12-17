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

orbits = all_direct_orbits(input)

def transfers(orbits, from)
  path = []
  while orbits[from]
    from = orbits[from]
    path << from
  end
  path
end

you = transfers(orbits, "YOU")
santa = transfers(orbits, "SAN")

def find_intersection(you, santa)
  you.find do |obj|
    santa.include?(obj)
  end
end

ap you.index(find_intersection(you, santa)) + santa.index(find_intersection(you, santa))