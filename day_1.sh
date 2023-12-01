#!/bin/bash

part_one() {
  awk '{gsub(/[^0-9]+/, " "); sum+=substr($1, 1, 1)substr($NF, length($NF), 1)} END{printf "%.0f\n", sum}'
}


NUMS=("one" "two" "three" "four" "five" "six" "seven" "eight" "nine")
part_two() {
  sum=0
  while IFS= read -r line; do
    line=$(echo "$line" | tr -d '\r' | sed -e 's/[[:space:]]*$//')

    first=""
    last=""
    str=""

    for ((i=0; i<${#line}; i++)); do
      ch="${line:i:1}"
      [[ $ch =~ [0-9] ]] && { [ -z "$first" ] && first="$ch"; last="$ch"; str=""; continue; }
      str+="$ch"

      for ((j=0; j<${#NUMS[@]}; j++)); do
        [[ $str == *"${NUMS[j]}"* ]] && { [ -z "$first" ] && first=$((j + 1)); last=$((j + 1)); str="${str: -1}"; break; }
      done
    done

    ((sum += "$first$last"))
  done
  echo "$sum"
}

echo "Part 1: $(cat input.txt | part_one)"
echo "Part 2: $(cat input.txt | part_two)"
