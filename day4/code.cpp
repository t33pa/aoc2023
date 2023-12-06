#include<algorithm>
#include<iostream>
#include<fstream>
#include<string>
#include<sstream>
#include<vector>


using namespace std;

vector<string> split(string str, char delimiter)
{
    vector<string> internal;
    stringstream ss(str);
    string tok;

    while(getline(ss, tok, delimiter))
    {
        internal.push_back(tok);
    }

    return internal;
}

int main()
{
    string FILEPATH = "input.txt";
    int score = 0;
    int res = 0;

    ifstream file(FILEPATH);
    string line;

    int count = 0;
    vector<int> matchCount;
    vector<int> totalCardCount;

    while (getline(file, line))
    {
        string cardSection = line.substr(line.find(":") + 1);
        string leftSide = cardSection.substr(0, cardSection.find("|"));
        string rightSide = cardSection.substr(cardSection.find("|") + 1);

        leftSide.erase(unique(leftSide.begin(), leftSide.end(), [](char a, char b){ return isspace(a) && isspace(b);}), leftSide.end());
        rightSide.erase(unique(rightSide.begin(), rightSide.end(), [](char a, char b){ return isspace(a) && isspace(b);}), rightSide.end());

        leftSide.erase(0, 1);
        rightSide.erase(0, 1);

        rightSide.erase(rightSide.length() - 1);

        vector<string> leftCards = split(leftSide, ' ');
        vector<string> rightCards = split(rightSide, ' ');

        count = 0;

        for (auto &card : rightCards)
        {
            card.erase(remove(card.begin(), card.end(), ' '), card.end());
            if (find(leftCards.begin(), leftCards.end(), card) != leftCards.end())
            {
                count++; 
                if (score == 0) {
                    score = 1;
                } else {
                    score *= 2;
                }
            }
        }

        matchCount.push_back(count);
        totalCardCount.push_back(1);

        res += score;
        score = 0;

    }

    for (int i = 0; i < totalCardCount.size(); i++)
    {
        for (int j = i; j < matchCount[i]+i; j++) {
            totalCardCount[j+1] += 1 * totalCardCount[i];
        }
    }

    cout << "Part1: " << res << endl;

    int total;

    for (auto &num : totalCardCount) {
        total += num;
    }

    cout << "Part2: " << total << endl;

    return 0;
}
