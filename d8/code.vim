function! GetMap(rows)
  let map = {}
  for row in a:rows
    let left = split(row, ' = ')[0]
    let right = split(row, ' = ')[1]
    let right = substitute(right, '(', '', 'g')
    let right = substitute(right, ')', '', 'g')
    let tmp = ["", ""]
    let tmp[0] = split(right, ', ')[0]
    let tmp[1] = split(right, ', ')[1]
    let map[left] = tmp
  endfor
  return map
endfunction

function! GetStartPoints(map)
  let startPoints = []
  for key in keys(a:map)
    if key[2] == "A"
      call add(startPoints, key)
    endif
  endfor
  return startPoints
endfunction

function! CheckGoaled(startPoints)
  for startPoint in a:startPoints
    if startPoint[2] != "Z"
      return 0
    endif
  endfor
  return 1
endfunction

function! GCD(a, b)
  let a = a:a
  let b = a:b
  while b != 0
    let temp = b
    let b = a % b
    let a = temp
  endwhile
  return a
endfunction

function! LCM(numbers)
  let result = a:numbers[0]
  for i in range(1, len(a:numbers) - 1)
    let result = result * a:numbers[i] / GCD(result, a:numbers[i])
  endfor

  return result
endfunction

let filename="input.txt"
let lines=readfile(filename,100)
let moveCommand = lines[0]
let map = GetMap(lines[2:])
let place = "AAA"

let goal = "ZZZ"
let ans = 0
let tmpCount = 0
let nums = []

while place != goal
  let ans = ans + 1
  if moveCommand[tmpCount] == "L"
    let place = map[place][0]
  else
    let place = map[place][1]
  endif
  let tmpCount = (tmpCount + 1) % len(moveCommand)
endwhile

echo "Part 1"
echo ans

" Part 2
let startPoints = GetStartPoints(map)
let ans = 0
let tmpCount = 0
for startPoint in startPoints
  let ans = 0
  let tmpCount = 0
  let place = startPoint
  while 1
    if (CheckGoaled([place]))
      call add(nums, ans)
      break
    endif
    let ans = ans + 1
    if moveCommand[tmpCount] == "L"
        let place = map[place][0]
      else
        let place = map[place][1]
      endif
    let tmpCount = (tmpCount + 1) % len(moveCommand)
  endwhile
endfor

echo "Part 2"
echo LCM(nums)
