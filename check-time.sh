#!/usr/bin/env bash

# check-time.sh [HH:MM]
# Checks whether it is HH:MM yet today in local time. Defaults to 22:20 (10:20pm).

set -euo pipefail

target_str=${1:-22:20}
if [[ ! $target_str =~ ^([0-1]?[0-9]|2[0-3]):([0-5][0-9])$ ]]; then
  echo "Usage: $0 [HH:MM]" >&2
  exit 2
fi

target_h=${target_str%%:*}
target_m=${target_str##*:}

now_h=$(date +%H)
now_m=$(date +%M)
now=$((10#$now_h*60 + 10#$now_m))
target=$((10#$target_h*60 + 10#$target_m))

printf "Now: %s\n" "$(date '+%Y-%m-%d %I:%M:%S %p %Z')"
if (( now >= target )); then
  echo "Has ${target_str} arrived today? yes"
  exit 0
else
  echo "Has ${target_str} arrived today? no"
  exit 1
fi
