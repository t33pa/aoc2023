const fs = require("fs");

interface Point {
  x: number;
  y: number;
}

const readFile = (path: string): string[][] => {
  const fileContent = fs.readFileSync(path, "utf8").split("\n");
  const grid: string[][] = [];

  for (let i = 0; i < fileContent.length; i++) {
    grid.push(fileContent[i].split(""));
  }

  return grid;
};

const checkColumn = (grid: string[][], column: number): boolean => {
  for (let i = 0; i < grid.length; i++) {
    if (grid[i][column] === "#") {
      return false;
    }
  }
  return true;
};

const insertColumn = (grid: string[][], column: number): string[][] => {
  for (let i = 0; i < grid.length; i++) {
    grid[i].splice(column, 0, "?");
  }
  return grid;
};

const expandGrid = (grid: string[][]): string[][] => {
  let newGrid: string[][] = [];
  for (let i = 0; i < grid[0].length; i++) {
    if (checkColumn(grid, i)) {
      grid = insertColumn(grid, i);
      i++;
    }
  }

  for (let i = 0; i < grid.length; i++) {
    if (grid[i].every((char) => char === "." || char === "?")) {
      newGrid.push(Array(grid[0].length).fill("?"));
    }
    newGrid.push(grid[i]);
  }

  return newGrid;
};

const getStarPoints = (grid: string[][]): Point[] => {
  let points: Point[] = [];
  for (let i = 0; i < grid.length; i++) {
    for (let j = 0; j < grid[0].length; j++) {
      if (grid[i][j] === "#") {
        points.push({ x: j, y: i });
      }
    }
  }
  return points;
};

const distance = (point1: Point, point2: Point, grid: string[][]): number => {
  // Change this value to 1 for part 1
  const questionValue = 999999;

  let smallX: number;
  let largeX: number;
  let smallY: number;
  let largeY: number;
  let startX: number;
  let startY: number;
  let distance = 0;
  if (point1.x >= point2.x) {
    smallX = point2.x;
    largeX = point1.x;
    startY = point2.y;
  } else {
    smallX = point1.x;
    largeX = point2.x;
    startY = point1.y;
  }
  if (point1.y >= point2.y) {
    smallY = point2.y;
    largeY = point1.y;
    startX = point2.x;
  } else {
    smallY = point1.y;
    largeY = point2.y;
    startX = point1.x;
  }

  for (let i = smallX + 1; i < largeX + 1; i++) {
    if (grid[startY][i] === "?") {
      distance += questionValue;
    } else {
      distance++;
    }
  }

  for (let i = smallY + 1; i < largeY + 1; i++) {
    if (grid[i][startX] === "?") {
      distance += questionValue;
    } else {
      distance++;
    }
  }
  return distance;
};

const main = () => {
  const path = "./input.txt";
  const grid = readFile(path);
  grid.pop();
  const expandedGrid = expandGrid(grid);
  const points = getStarPoints(expandedGrid);
  let ans = 0;

  for (let i = 0; i < points.length - 1; i++) {
    for (let j = i + 1; j < points.length; j++) {
      ans += distance(points[i], points[j], expandedGrid);
    }
  }
  console.log(ans);
};

main();
