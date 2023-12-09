const fs = require("fs");
const filePath = "./input.txt";

const readFile = (path) => {
  const file = fs.readFileSync(path, "utf8");
  return file.split("\r\n\r\n");
};

const getSeedList = (line) => {
  return line
    .split(" ")
    .slice(1)
    .map((s) => parseInt(s));
};

const parseMap = (map) => {
  let res = map.split("\r\n").slice(1);
  for (let i = 0; i < res.length; i++) {
    res[i] = res[i].split(" ");
    res[i] = res[i].map((e) => parseInt(e));
  }
  return res;
};

const createSeedPairs = (seedList) => {
  let seedPairs = [];
  for (let i = 0; i < seedList.length; i += 2) {
    seedPairs.push([seedList[i], seedList[i] + seedList[i + 1] - 1]);
  }
  return seedPairs;
};

const main = () => {
  const splitedFile = readFile(filePath);
  const seedList = getSeedList(splitedFile[0]);
  const seedPairs = createSeedPairs(seedList);

  let ans = Infinity;
  let mapList = splitedFile.slice(1);
  mapList = mapList.map((m) => parseMap(m));
  let loc;

  for (let h = 0; h < seedList.length; h++) {
    loc = seedList[h];
    for (let i = 0; i < mapList.length; i++) {
      for (let j = 0; j < mapList[i].length; j++) {
        let [rightStart, leftStart, size] = mapList[i][j];
        if (loc >= leftStart && loc <= leftStart + size - 1) {
          loc += rightStart - leftStart;
          break;
        }
      }
    }
    ans = Math.min(loc, ans);
  }
  console.log(ans);

  // For part 2
  ans = Infinity;
  loc = 0;
  for (let g = 0; g < seedPairs.length; g++) {
    for (let h = seedPairs[g][0]; h < seedPairs[g][1]; h++) {
      loc = h;
      for (let i = 0; i < mapList.length; i++) {
        for (let j = 0; j < mapList[i].length; j++) {
          let [rightStart, leftStart, size] = mapList[i][j];
          if (loc >= leftStart && loc <= leftStart + size - 1) {
            loc += rightStart - leftStart;
            break;
          }
        }
      }
      ans = Math.min(loc, ans);
    }
  }
  console.log(ans);
};

main();
