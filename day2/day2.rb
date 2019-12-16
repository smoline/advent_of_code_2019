require 'ap'

file = File.open("day2_input.txt")
operation_codes = file.read.split(",").map(&:to_i)

def solve_for_opcodes(operation_codes)
  opcodes = operation_codes.dup

  opcodes[1] = 12
  opcodes[2] = 2

  index = 0

  loop do
    opcode, position1, position2, target = opcodes[index..index + 4]

    case opcode
    when 1
      opcodes[target] = opcodes[position1] + opcodes[position2]
    when 2
      opcodes[target] = opcodes[position1] * opcodes[position2]
    when 99
      result = opcodes[0]
      break result
    end

    index += 4
  end
end

ap solve_for_opcodes(operation_codes)


# determine what pair of inputs produces the output 19690720.
def new_opcodes(operation_codes)
  (0..99).each do |first_noun|
    (0..99).each do |first_verb|
      opcodes = operation_codes.dup

      # required variables 
      opcodes[1] = first_noun
      opcodes[2] = first_verb

      instruction_pointer = 0

      loop do
        opcode, noun, verb, target = opcodes[instruction_pointer..instruction_pointer + 4]

        case opcode
        when 1
          opcodes[target] = opcodes[noun] + opcodes[verb]
        when 2
          opcodes[target] = opcodes[noun] * opcodes[verb]
        when 99
          if opcodes[0] == 19690720
            ap first_noun * 100 + first_verb
            exit
          end
          break "no result"
        end
        instruction_pointer += 4
      end
    end
  end
end


ap new_opcodes(operation_codes)