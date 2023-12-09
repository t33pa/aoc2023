#include<stdio.h>

long findPossibleTimes(long time, long record) {
    long result = 0;
    for (long i = 1; i < time; i++) {
        if ((time - i) * i > record) {
            result++;
        }
    }
    return result;
}

int main() {
    long time[4] = // Input
    long record[4] = // Input
    long time2 = // Input
    long record2 = // Input
    long result = 1;

    for (int i = 0; i < 4; i++) {
        result *= findPossibleTimes(time[i], record[i]);
    }

    printf("Answer1: %ld\n", result);

    printf("Answer2: %ld\n", findPossibleTimes(time2, record2));

    return 0;
}
