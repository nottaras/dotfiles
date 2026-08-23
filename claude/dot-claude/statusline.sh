#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')

CYAN='\033[36m'; GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'; MAGENTA='\033[35m'; RESET='\033[0m'

# Pick bar color based on context usage
if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"; fi

FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
BAR="${FILL// /█}${PAD// /░}"

MINS=$((DURATION_MS / 60000)); SECS=$(((DURATION_MS % 60000) / 1000))

BRANCH=""
git rev-parse --git-dir > /dev/null 2>&1 && BRANCH=" | 🌿 $(git branch --show-current 2>/dev/null)"

echo -e "${CYAN}[$MODEL]${RESET} 📁 ${DIR##*/}$BRANCH"

COST_FMT=$(printf '$%.2f' "$COST")

# Daily cost from JSONL logs (cached 30s)
DAILY_LINE=""
daily_raw=$(python3 "${CLAUDE_CONFIG_DIR:-$HOME/.claude}/daily-cost.py" 2>/dev/null)
if [ -n "$daily_raw" ]; then
  today_scaled=$(echo "$daily_raw" | cut -d'|' -f1)
  today_in=$(echo "$daily_raw" | cut -d'|' -f3)
  today_out=$(echo "$daily_raw" | cut -d'|' -f4)
  DAILY_LINE=" | ${MAGENTA}today:${today_scaled} (in:${today_in} out:${today_out})${RESET}"
fi

LAST_RESP=$(date '+%Y-%m-%d %H:%M:%S')
echo -e "${BAR_COLOR}${BAR}${RESET} ${PCT}% | ${YELLOW}${COST_FMT}${RESET}${DAILY_LINE} | ⏱️ ${MINS}m ${SECS}s | 🕐 ${LAST_RESP}"
