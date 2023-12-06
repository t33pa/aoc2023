<?php

class NumPosition {
  public $value;
  public $row;
  public $col;

  public function __construct($value, $row, $col) {
    $this->value = $value;
    $this->row = $row;
    $this->col = $col;
    $this->len = strlen($value);
  }

  public function get_adjacent_positions() {
    $position_list = array();
    array_push($position_list, [$this->row, $this->col-1]);
    array_push($position_list, [$this->row, $this->col + $this->len]);
    array_push($position_list, [$this->row-1, $this->col-1]);
    array_push($position_list, [$this->row+1, $this->col-1]);
    array_push($position_list, [$this->row-1, $this->col + $this->len]);
    array_push($position_list, [$this->row+1, $this->col + $this->len]);

    for ($i = 0; $i < $this->len; $i++) {
      array_push($position_list, [$this->row-1, $this->col + $i]);
      array_push($position_list, [$this->row+1, $this->col + $i]);
    }
    return $position_list;
  }
}


function isValidPosition($row, $col, $grid) {
  return $row >= 0 && $row < count($grid) && $col >= 0 && $col < count($grid[0]);
}

function isSymbol($char) {
  return $char != '.';
}

function remove_element_from_stack($gear_stack, $value) {
  $new_stack = array();
  foreach($gear_stack as $gear) {
    if ($gear[1] != $value) {
      array_push($new_stack, $gear);
    }
  }
  return $new_stack;
}

// Read the file line by line
$lines = file("input.txt");
$grid = array();

foreach($lines as $line) {
  $line = trim($line);
  array_push($grid, str_split($line));
}

$tmp_num = "";
$is_in_num = false;
$num_pos_list = array();

for ($i = 0; $i < count($grid); $i++) {
  $is_in_num = false;
  for ($j = 0; $j < count($grid[$i]); $j++) {
    if (is_numeric($grid[$i][$j]) and !$is_in_num) {
      $tmp_num = $grid[$i][$j];
      $is_in_num = true;
    } elseif (is_numeric($grid[$i][$j]) and $is_in_num and $j == count($grid[$i])-1) {
      $tmp_num .= $grid[$i][$j];
      array_push($num_pos_list, new NumPosition($tmp_num, $i, $j-strlen($tmp_num)+1));
    } elseif (is_numeric($grid[$i][$j]) and $is_in_num) {
      $tmp_num .= $grid[$i][$j];
    } elseif (!is_numeric($grid[$i][$j]) and $is_in_num) {
      $is_in_num = false;
      array_push($num_pos_list, new NumPosition($tmp_num, $i, $j-strlen($tmp_num)));
    }
  }
}

$sum = 0;
foreach($num_pos_list as $num_pos) {
  $adjacent_positions = $num_pos->get_adjacent_positions();
  //print_adjacent_positions($adjacent_positions);
  foreach($adjacent_positions as $adj_pos) {
    if (isValidPosition($adj_pos[0], $adj_pos[1], $grid) && isSymbol($grid[$adj_pos[0]][$adj_pos[1]])) {
      $sum += intval($num_pos->value);
      break;
    }
  }
}

echo "Answer1: " . $sum . "\n";

// Part 2
$sum = 0;
$gear_stack = array();

foreach($num_pos_list as $num_pos) {
  $adjacent_positions = $num_pos->get_adjacent_positions();
  foreach($adjacent_positions as $adj_pos) {
    if (isValidPosition($adj_pos[0], $adj_pos[1], $grid) && $grid[$adj_pos[0]][$adj_pos[1]] == "*") {
      if (count($gear_stack) == 0) {
        array_push($gear_stack, [$num_pos->value, strval($adj_pos[0]).strval($adj_pos[1])]);
      } else {
        foreach($gear_stack as $gear) {
          if ($gear[1] == strval($adj_pos[0]).strval($adj_pos[1])) {
            $sum += intval($num_pos->value) * intval($gear[0]);
            $gear_stack = remove_element_from_stack($gear_stack, $gear[1]);
            goto label;
          }
        }
        array_push($gear_stack, [$num_pos->value, strval($adj_pos[0]).strval($adj_pos[1])]);
      }
    }
  }
  label:
}

echo "Answer2: " . $sum . "\n";
