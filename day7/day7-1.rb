file = File.open("day7_input.txt")
operation_codes = file.read.split(",").map(&:to_i)

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

def intcode_comp(opcodes, inp, phase)
  ip = 0
  output = nil

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
      opcodes[position] = phase || inp
      ip += 1
      phase = nil
    when 4
      target = opcodes[ip += 1]
      output = opcodes[target]
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
      break output
    else
      raise "error"
    end
  end
end

best = 0

(0..4).to_a.permutation.each do |phases|
  inp = 0
  phases.each do |phase|
    opcodes = operation_codes.dup
    inp = intcode_comp(operation_codes, inp, phase)
  end

  best = [inp, best].max
end

puts best