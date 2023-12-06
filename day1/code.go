package main

import (
        "bufio"
        "fmt"
        "os"
        "regexp"
        "strconv"
        "strings"
)

func removeNonNumeric(input string) string {
        re := regexp.MustCompile("[^0-9]+")
        return re.ReplaceAllString(input, "")
}

func replaceLetterToNumber(input string) string {
        dicts := map[string]string{
                "one":   "o1e",
                "two":   "t2o",
                "three": "t3e",
                "four":  "f4",
                "five":  "f5e",
                "six":   "s6",
                "seven": "s7n",
                "eight": "e8t",
                "nine":  "n9e",
        }

        numberSpellings := []string{"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
  
        for _, num := range numberSpellings {
                input = strings.Replace(input, letter, dicts[num], -1)
        }

        return input

}

func main() {
        const filename = "input.txt"
        res := 0
        file, err := os.Open(filename)
        if err != nil {
                panic(err)
        }
        defer file.Close()

        scanner := bufio.NewScanner(file)
        for scanner.Scan() {
                line := scanner.Text()

                // Comment out this to solve the first part of the problem
                line = replaceLetterToNumber(line)

                numbers := removeNonNumeric(line)

                if len(numbers) == 0 {
                        continue
                } else if len(numbers) == 1 {
                        i, err := strconv.Atoi(numbers + numbers)
                        if err != nil {
                                panic(err)
                        }
                        res += i
                } else {
                        first := numbers[0:1]
                        last := numbers[len(numbers)-1:]
                        i, err := strconv.Atoi(first + last)
                        if err != nil {
                                panic(err)
                        }
                        res += i
                }
        }

        fmt.Println(res)

}
