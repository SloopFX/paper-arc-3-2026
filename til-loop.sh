#!/usr/bin/env bash

# til-loop.sh: Helper to monitor time milestones and print prompts.
# Does NOT edit files; useful for manual iteration pacing.

set -euo pipefail

TARGET=${1:-22:20}
INTERVAL=${INTERVAL:-60}

echo "Monitoring until ${TARGET} local..."
while true; do
  if ./check-time.sh "$TARGET" >/dev/null; then
    echo "Reached $TARGET — stop editing loop."
    exit 0
  fi
  ./check-time.sh 22:00 || true
  echo "— continue editing — (sleep ${INTERVAL}s)"
  sleep "$INTERVAL"
done

