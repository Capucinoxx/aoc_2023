#!/bin/bash

declare -A NUMS
NUMS=(["one"]="1" ["two"]="2" ["three"]="3" ["four"]="4" ["five"]="5" ["six"]="6" ["seven"]="7" ["eight"]="8" ["nine"]="9")

sum() { awk '{sum += $1} END {print sum}'; }

calculate() {
  local -n dict="${1:-dicts}"

  while IFS= read -r line; do
    first=""
    last=""
    str=""

    for ((i=0; i<${#line}; i++)); do
      ch="${line:i:1}"
      [[ $ch =~ [0-9] ]] && { [ -z "$first" ] && first="$ch"; last="$ch"; str=""; continue; }
      str+="$ch"

      for val in "${!dict[@]}"; do
        [[ $str == *"$val"* ]] && { [ -z "$first" ] && first="${dict[$val]}"; last="${dict[$val]}"; str="${str: -1}"; break; }
      done
    done
    echo "$first$last"
  done
}

echo "Part 1: $(cat input.txt | calculate | sum)"
echo "Part 2: $(cat input.txt | calculate NUMS | sum)"
