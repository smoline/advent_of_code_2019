require 'ap'

file = File.open("day5_input.txt")
opcodes = file.read.split(",").map(&:to_i)

def value(opcodes, ip, mode)
  value = opcodes[ip]

  case mode
  when 0
    opcodes[value]
  when 1
    value
  else
    raise "error"
  end
end

def intcode_comp(opcodes)
  ip = 0
  
  loop do
    pm3, pm2, pm1, op1, op2 = opcodes[ip].to_s.rjust(5, "0").chars.map(&:to_i)

    case op1 * 10 + op2
    when 1
      a = value(opcodes, ip += 1, pm1)
      b = value(opcodes, ip += 1, pm2)
      position = opcodes[ip += 1]
      opcodes[position] = a.to_i + b.to_i
      ip += 1
    when 2
      a = value(opcodes, ip += 1, pm1)
      b = value(opcodes, ip += 1, pm2)
      position = opcodes[ip += 1]
      opcodes[position] = a * b
      ip += 1
    when 3
      position = opcodes[ip += 1]
      opcodes[position] = 5
      ip += 1
    when 4
      target = opcodes[ip += 1]
      puts opcodes[target]
      ip += 1
    when 5
      a = value(opcodes, ip += 1, pm1)
      b = value(opcodes, ip += 1, pm2)
      ip = a.zero? ? ip + 1 : b
    when 6
      a = value(opcodes, ip += 1, pm1)
      b = value(opcodes, ip += 1, pm2)
      ip = a.zero? ? b : ip + 1
    when 7
      a = value(opcodes, ip += 1, pm1)
      b = value(opcodes, ip += 1, pm2)
      position = opcodes[ip += 1]
      opcodes[position] = a < b ? 1 : 0
      ip += 1
    when 8
      a = value(opcodes, ip += 1, pm1)
      b = value(opcodes, ip += 1, pm2)
      position = opcodes[ip += 1]
      opcodes[position] = a == b ? 1 : 0
      ip += 1
    when 99
      break
    else
      raise "error"
    end
  end
end

ap intcode_comp(opcodes)