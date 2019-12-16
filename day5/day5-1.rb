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

def incode_comp(opcodes)
  ip = 0
  
  loop do
    pm3, pm2, pm1, op1, op2 = opcodes[ip].to_s.rjust(5, "0").chars.map(&:to_i)

    case op1 * 10 + op2
    when 1
      a = value(opcodes, ip += 1, pm1)
      b = value(opcodes, ip += 1, pm2)
      position = opcodes[ip += 1]
      opcodes[position] = a + b
    when 2
      a = value(opcodes, ip += 1, pm1)
      b = value(opcodes, ip += 1, pm2)
      position = opcodes[ip += 1]
      opcodes[position] = a * b
    when 3
      position = opcodes[ip += 1]
      opcodes[position] = 1
    when 4
      target = opcodes[ip += 1]
      puts opcodes[target]
    when 99
      break
    else
      raise "error"
    end
    ip += 1
  end
end

ap incode_comp(opcodes)