require 'ap'

file = File.open("day1_input.txt")
modules = file.readlines.map(&:to_i)

def fuel_counter_upper(modules)
  fuel = 0
  modules.each { |mass| fuel += mass / 3 - 2 }
  return fuel
end

ap fuel_counter_upper(modules)


def new_fuel(modules)
  fuel = 0
  modules.each do |mass|
    while mass > 0
      mass = mass / 3 - 2
      fuel += mass
    end
  end
  return fuel
end

ap new_fuel(modules)

def another_fuel(mass)
  amount = [mass / 3 - 2, 0].max

  amount > 0 ? amount + another_fuel(amount) : amount
end

ap modules.sum { |mass| another_fuel(mass) }