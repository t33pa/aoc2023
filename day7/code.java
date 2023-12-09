package q7;

import java.util.LinkedHashSet;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.ArrayList;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

class Bet {
    String hands;
    int bet;
    int rank;
    Bet(String hands, int bet) {
        this.hands = hands;
        this.bet = bet;
    }

    public static int getCardValue(char c, boolean isPart2) {
        if (c == 'J' && isPart2) return 0;
        switch (c) {
            case 'A': return 14;
            case 'K': return 13;
            case 'Q': return 12;
            case 'J': return 11;
            case 'T': return 10;
            default: return Integer.parseInt(String.valueOf(c));
        }
    }

    public int getRank(String hand){
        int[] counts = new int[15];
        int pairs = 0;
        int threes = 0;
        int fours = 0;
        int fives = 0;
        for (char c : hand.toCharArray()) {
            counts[getCardValue(c, false)]++;
        }

        for (int count : counts) {
            if (count == 2) pairs++;
            if (count == 3) threes++;
            if (count == 4) fours++;
            if (count == 5) fives++;
        }

        if (fives >= 1) return 7;
        if (fours >= 1) return 6;
        if ((threes == 1 && pairs == 1) || threes == 2) return 5;
        if (threes >= 1) return 4;
        if (pairs == 2) return 3;
        if (pairs == 1 || pairs == 4) return 2;
        return 1;
    }

    private String removeDuplicates(String input) {
    char[] characters = input.toCharArray();
    LinkedHashSet<Character> charSet = new LinkedHashSet<>();
    for (char c : characters) {
        charSet.add(c);
    }
    StringBuilder sb = new StringBuilder();
    for (Character character : charSet) {
        sb.append(character);
    }
    return sb.toString();
}

    public int getRankPart2(String hand) {
        if (hand.equals("JJJJJ")) {
            return 7;
        }
        String newHand = hand;
        String tmp = removeDuplicates(hand.replaceAll("J", ""));
        newHand = hand.replaceAll("J", tmp);
        return getRank(newHand);
    }

    public void print() {
        System.out.println(this.hands + " " + this.bet);
    }
}

class Code {
    public static String readFile(String filename) throws IOException {
        final Path path = Paths.get(filename);
        byte[] bytes = Files.readAllBytes(path);
        return new String(bytes);
    }

    public static void main(String[] args) {
        final String filename = "q7/input.txt";
        String content = "";
        int res = 0;
        try {
            content = readFile(filename);
        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
        }

        final String[] lines = content.split("\r\n");
        Bet[] bets = new Bet[lines.length];
        for (int i = 0; i < lines.length; i++) {
            String[] parts = lines[i].split(" ");
            bets[i] = new Bet(parts[0], Integer.parseInt(parts[1]));
        }

        List<List<Bet>> sortedBets = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            sortedBets.add(new ArrayList<>());
        }

        for (Bet bet : bets) {
            // getRank for part 1
            sortedBets.get(bet.getRankPart2(bet.hands) - 1).add(bet);
        }

        for (List<Bet> betList : sortedBets) {
            Collections.sort(betList, new Comparator<Bet>() {
                @Override
                public int compare(Bet bet1, Bet bet2) {
                    for (int i = 0; i < bet1.hands.length(); i++) {
                        // Make isPart2 false for part 1
                        int card1Value = Bet.getCardValue(bet1.hands.charAt(i), true);
                        int card2Value = Bet.getCardValue(bet2.hands.charAt(i), true);
                        if (card1Value < card2Value) {
                            return -1;
                        } else if (card1Value > card2Value) {
                            return 1;
                        }
                    }
                    return 0;
                }
            });
        }

        List<Bet> flatList = new ArrayList<>();
        for (List<Bet> tmp : sortedBets) {
            flatList.addAll(tmp);
        }
        for (int i = 0; i < flatList.size(); i++) {
            Bet bet = flatList.get(i);
            res += bet.bet * (i + 1);
        }
        System.out.println(res);
    }
}
