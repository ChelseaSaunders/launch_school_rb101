# Write a method that takes a string, and then returns a hash that contains 3
# entries: one represents the number of characters in the string that are
# lowercase letters, one the number of characters that are uppercase letters,
# and one the number of characters that are neither.

# PROBLEM:
#   Input: string
#   Output: hash with number of lowercase chars in string, number of uppercase
#           chars in string, number of chars that are neither
#   Rules:
#     Explicit:
#     Implicit:

# EXAMPLES/TEST CASES:

# DATA:

# ALOGORITHM:

# CODE:

LOWERCASE_LETTERS = ('a'..'z')
UPPERCASE_LETTERS = ('A'..'Z')

def letter_case_count(string)
  case_count_hash = { lowercase: 0, uppercase: 0, neither: 0 }

  string.each_char do |char|
    if LOWERCASE_LETTERS.include?(char)
      case_count_hash[:lowercase] += 1
    elsif UPPERCASE_LETTERS.include?(char)
      case_count_hash[:uppercase] += 1
    else
      case_count_hash[:neither] += 1
    end
  end

  case_count_hash
end

p letter_case_count('abCdef 123') == { lowercase: 5, uppercase: 1, neither: 4 }
p letter_case_count('AbCd +Ef') == { lowercase: 3, uppercase: 3, neither: 2 }
p letter_case_count('123') == { lowercase: 0, uppercase: 0, neither: 3 }
p letter_case_count('') == { lowercase: 0, uppercase: 0, neither: 0 }
