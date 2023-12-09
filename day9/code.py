def sub_row(row, res, is_part2):
    new_row = []
    for i in range(len(row) - 1):
        new_row.append(row[i+1] - row[i])

    if all(element == 0 for element in new_row):
        return res
    else:
        if is_part2:
            res.append(new_row[0])
        else:
            res.append(new_row[-1])
        return sub_row(new_row, res, is_part2)


def main():
    file_path = "input.txt"
    ans = 0
    rows = []
    with open(file_path, "r") as f:
        rows = f.readlines()
    for row in rows:
        row = row.split(" ")
        row = list(map(lambda x: int(x), row))
        res = sub_row(row, [], False)
        ans += (sum(res) + row[-1])

    print("part1: {}".format(ans))

    # Part 2
    ans = 0
    for row in rows:
        row = row.split(" ")
        row = list(map(lambda x: int(x), row))
        res = list(reversed(sub_row(row, [], True)))
        for i in range(1, len(res)):
            res[i] = res[i] - res[i-1]
        ans += row[0] - res[-1]

    print("part2: {}".format(ans))


if __name__ == '__main__':
    main()
