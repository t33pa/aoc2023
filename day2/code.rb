# consts
FILE_PATH = "input.txt"
RED_MAX = 12
GREEN_MAX = 13
BLUE_MAX = 14

class Game
  def initialize(id, subsets)
    @id = id
    @subsets = subsets
  end

  def id
    @id
  end

  def subsets
    @subsets
  end
end

class Subset
  def initialize(pulls)
    @pulls = pulls
  end

  def pulls
    @pulls
  end
end

class Pull
  def initialize(color, amount)
    @color = color
    @amount = amount
  end

  def color
    @color
  end

  def amount
    @amount
  end
end

def parsePull(pull)
  pull.strip!
  amount, color = pull.split(" ")
  return Pull.new(color, amount)
end

def parseSubset(subset)
  splited = subset.split(", ")
  return Subset.new(splited.map { |pull| parsePull(pull) })
end

def parseGame(line)
  game_id = line.split(": ")[0].split(" ")[1]
  subsets = line.split(": ")[1].split(";")
  subsets = subsets.map { |subset| parseSubset(subset) }
  return Game.new(game_id, subsets)
end

def part1(games)
  res = 0

  games.each do |game|
    is_valid = true
    game.subsets.each do |subset|
      cube_count = { "red" => 0, "green" => 0, "blue" => 0 }
      subset.pulls.each do |pull|
        cube_count[pull.color] += pull.amount.to_i
        if cube_count["red"] > RED_MAX || cube_count["green"] > GREEN_MAX || cube_count["blue"] > BLUE_MAX
          is_valid = false
        end
      end
    end
    if is_valid
      res += game.id.to_i
    end
  end
  return res
end

def part2(games)
  res = 0
  min_red = 0
  min_green = 0
  min_blue = 0

  cubes = { "red" => 0, "green" => 0, "blue" => 0 }

  games.each do |game|
    game.subsets.each do |subset|
      subset.pulls.each do |pull|
        cubes[pull.color] += pull.amount.to_i
      end
      min_red = [min_red, cubes["red"]].max
      min_green = [min_green, cubes["green"]].max
      min_blue = [min_blue, cubes["blue"]].max
      cubes = { "red" => 0, "green" => 0, "blue" => 0 }
    end
    res += min_red * min_green * min_blue
    min_red = 0
    min_green = 0
    min_blue = 0
  end
  return res
end

def main()
  games = []
  res = 0
  File.open(FILE_PATH, "r") do |f|
    f.each_line do |line|
      games.push(parseGame(line))
    end
  end

  ans1 = part1(games)
  ans2 = part2(games)

  puts "Part 1: #{ans1}"
  puts "Part 2: #{ans2}"
end

main()
