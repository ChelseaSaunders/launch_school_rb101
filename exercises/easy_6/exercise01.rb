# Write a method that takes a floating point number that represents an angle
# between 0 and 360 degrees and returns a String that represents that angle in
# degrees, minutes and seconds. You should use a degree symbol (°) to represent
# degrees, a single quote (') to represent minutes, and a double quote (") to
# represent seconds. A degree has 60 minutes, while a minute has 60 seconds.

# PROBLEM:
#   Input: float representing number between 0 and 360
#   Output: string representing output in degrees, minutes, and seconds, with
#           appropriate symbols
#   Rules:
#     Explicit:
#     Implicit:

# EXAMPLES/TEST CASES:

# DATA:
# Input is float, output is string.

# ALOGORITHM:

# CODE:

DEGREE = "\xC2\xB0"

MINUTES_PER_DEGREE = 60
SECONDS_PER_MINUTE = 60
SECONDS_PER DEGREE = MINUTES_PER DEGREE * SECONDS_PER_MINUTE

def dms(angle)
  degrees = angle.floor
  minutes = ((angle - degrees) * MINUTES_PER_DEGREE).round
  seconds = ((((angle - degrees) * 60) - minutes) * 60).round

  degrees + "°" + minutes + "'" + seconds + DEGREE
end

p dms(30) # == %(30°00'00")
p dms(76.73) # == %(76°43'48")
p dms(254.6) # == %(254°36'00")
p dms(93.034773) # == %(93°02'05")
p dms(0) # == %(0°00'00")
p dms(360) # == %(360°00'00") || dms(360) == %(0°00'00")
